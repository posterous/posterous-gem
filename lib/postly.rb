%w[typhoeus yaml json ostruct].each { |lib| require lib }

module Postly
  BASE_API_URL = 'http://posterous.com/api/v2'

  extend self

  attr_reader :config

  autoload :Connection,   'postly/connection'
  autoload :Inheritable,  'postly/inheritable'
  autoload :Model,        'postly/model'
  autoload :ManyProxy,    'postly/many_proxy'
  autoload :Site,         'postly/models/site'
  autoload :Post,         'postly/models/post'
  autoload :Page,         'postly/models/page'
  autoload :Comment,      'postly/models/comment'
  autoload :Like,         'postly/models/like'

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
