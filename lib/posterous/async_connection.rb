require 'eventmachine'
require 'em-http'
require 'fiber'

module Posterous
  module AsyncConnection

    ConnectionError = Class.new(StandardError)

    extend self


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

      request = EventMachine::HttpRequest.new(url).send(method, {
        :params => params.merge!(default_params), 
        :head 	=> {
          'authorization' => [Posterous.config['username'], Posterous.config['password']]
        }
      })
      request.callback { f.resume(request) }
      request.errback { f.resume(request) }

      Fiber.yield
    end

    [:get, :post, :put, :delete].each do |verb|
      define_method verb do |path, *args|
        
        params = args.last || {}

        puts "POSTLY :: #{verb.upcase} #{path} #{params}\n\n" if ENV['POSTLY_DEBUG']

        request_url = "#{Posterous::BASE_API_URL}#{path}"
        @resp       = nil
        
        EM.run do
          Fiber.new {
            response 	= async_request(verb, request_url, params)
            @resp 		= parse(response.response)
            EM.stop
          }.resume
        end
        @resp
      end
    end

  end
end
