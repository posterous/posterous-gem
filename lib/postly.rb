require 'typhoeus'
require 'yaml'
require 'json'
require 'ostruct'

module Postly
  BASE_API_URL = 'http://posterous.com/api/v2'

  autoload :Connection, 'postly/connection'
  extend self

  attr_reader :config

  def config=(cfg)
    @config = YAML.load_file(cfg) if cfg.is_a?(File)
    @config = cfg if cfg.is_a?(Hash)
  end
end
