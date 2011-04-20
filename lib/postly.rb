%w[typhoeus yaml json ostruct].each { |lib| require lib }

module Postly
  BASE_API_URL = 'http://posterous.com/api/v2'

  extend self

  attr_reader :config

  autoload :Connection,         'postly/connection'
  autoload :Inheritable,        'postly/inheritable'
  autoload :Model,              'postly/model'
  autoload :User,               'postly/models/user'
  autoload :Site,               'postly/models/site'
  autoload :Profile,            'postly/models/profile'
  autoload :Post,               'postly/models/post'
  autoload :Page,               'postly/models/page'
  autoload :Comment,            'postly/models/comment'
  autoload :Like,               'postly/models/like'
  autoload :Link,               'postly/models/link'
  autoload :LinkCategory,       'postly/models/link_category'
  autoload :ExternalSite,       'postly/models/external_site'
  autoload :Subscriber,         'postly/models/subscriber'
  autoload :Subscription,       'postly/models/subscription'
  autoload :AssociationProxy,   'postly/association_proxy'


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
