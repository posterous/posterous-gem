require 'eventmachine'
require 'em-http'
require 'fiber'

module Posterous
  module AsyncConnection

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

    def async_request method, url, params
      f = Fiber.current

      request = EventMachine::HttpRequest.new(url).send(method, {:params => params})
      request.callback { f.resume(request) }
      request.errback { f.resume(request) }

      Fiber.yield
    end

    [:get, :post, :put, :delete].each do |verb|
      define_method verb do |path, *args|
        
        params = args.last || {}

        puts "POSTLY :: #{verb.upcase} #{path} #{params}\n\n" if ENV['POSTLY_DEBUG']

        request_url = "#{Posterous::BASE_API_URL}#{path}"

        EM.run do
          Fiber.new {
            p "asdf"
            response = async_request(verb, request_url, params)
            p response
            EM.stop
          }.resume
        end

      end
    end

  end
end
