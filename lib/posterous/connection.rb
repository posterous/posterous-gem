module Posterous
  module Connection

    ConnectionError = Class.new(StandardError)

    extend self

    def http
      Typhoeus::Request
    end

    def default_options
      @default_options ||= { 
        :username => Posterous.config['username'], 
        :password => Posterous.config['password']
      }
    end

    def default_params
      @default_params ||= { :api_token => Posterous.config['api_token'] }
    end

    def parse json
      parsed = JSON.parse json
      parsed.delete('comments')
      return parsed.map{|r| r.delete('comments'); OpenStruct.new(r) } if parsed.is_a?(Array)
      OpenStruct.new(parsed)
    rescue
      nil
    end

    [:get, :post, :put, :delete].each do |verb|
      define_method verb do |path, *args|

        params = args.last || {}

        puts "POSTEROUS :: #{verb.to_s.upcase} #{path} #{params}\n\n" if ENV['POSTEROUS_DEBUG']

        response  = http.send(verb, "#{Posterous::BASE_API_URL}#{path}", 
                      default_options.merge!(:params => default_params.merge!(params)))
        result    = parse(response.body)

        puts "POSTEROUS :: #{response.body}\n\n" if ENV['POSTEROUS_DEBUG']

        unless [200,201].include?(response.code)
          msg = result.nil? ? response.body : "#{result.error} #{result.message}"
          raise ConnectionError, msg 
        end

        result
      end
    end

  end
end
