module Postly
  module Connection

    ConnectionError = Class.new(StandardError)

    extend self

    def http
      Typhoeus::Request
    end

    def default_options
      @default_options ||= { 
        :username => Postly.config['username'], 
        :password => Postly.config['password']
      }
    end

    def default_params
      @default_params ||= { :api_token => Postly.config['api_token'] }
    end

    def parse json
      parsed = JSON.parse json
      return parsed.map{|r| OpenStruct.new(r) } if parsed.is_a?(Array)
      OpenStruct.new(parsed)
    rescue
      nil
    end

    [:get, :post, :put, :delete].each do |verb|
      define_method verb do |path, params={}|
        puts "#{verb.upcase} #{path} #{params}" if ENV['POSTLY_DEBUG']

        response  = http.send(verb, "#{Postly::BASE_API_URL}#{path}", default_options.merge!(:params => default_params.merge!(params)))
        result    = parse(response.body)
        
        puts response.body if ENV['POSTLY_DEBUG']

        unless [200,201].include?(response.code)
          msg = result.nil? ? response.body : "#{result.error} #{result.message}"
          raise ConnectionError, msg 
        end

        result
      end
    end

  end
end
