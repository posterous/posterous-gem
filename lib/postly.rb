require 'typhoeus'
require 'yaml'
require 'json'
require 'ostruct'

module Postly
  BASE_API_URL = 'http://posterous.com/api/v2'

  autoload :Connection, 'postly/connection'
  autoload :Model,      'postly/model'
  autoload :ManyProxy,  'postly/many_proxy'
  autoload :Site,       'postly/site'
  
  extend self

  attr_reader :config

  def config=(cfg)
    @config = case
      when cfg.is_a?(File)
        YAML.load_file(cfg)
      when cfg.is_a?(Hash)
        cfg
      else
        raise ArgumentError, 'Invalid Config'
    end
  end
end
