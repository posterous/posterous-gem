%w[typhoeus yaml json ostruct].each { |lib| require lib }

require 'pathname'

dir = Pathname(__FILE__).dirname.expand_path

require dir + 'posterous/connection'
require dir + 'posterous/inheritable'
require dir + 'posterous/model'
require dir + 'posterous/models/tag'
require dir + 'posterous/models/subscriber'
require dir + 'posterous/models/subscription'
require dir + 'posterous/models/comment'
require dir + 'posterous/models/like'
require dir + 'posterous/models/post'
require dir + 'posterous/models/page'
require dir + 'posterous/models/link'
require dir + 'posterous/models/link_category'
require dir + 'posterous/models/external_site'
require dir + 'posterous/models/user'
require dir + 'posterous/models/profile'
require dir + 'posterous/models/site'
require dir + 'posterous/association_proxy'


module Posterous
  BASE_API_URL = 'http://posterous.com/api/v2'

  extend self

  attr_reader :config

  autoload :Connection,         'posterous/connection'
  autoload :Inheritable,        'posterous/inheritable'
  autoload :Model,              'posterous/model'
  autoload :Tag,                'posterous/models/tag'
  autoload :User,               'posterous/models/user'
  autoload :Site,               'posterous/models/site'
  autoload :Profile,            'posterous/models/profile'
  autoload :Post,               'posterous/models/post'
  autoload :Page,               'posterous/models/page'
  autoload :Comment,            'posterous/models/comment'
  autoload :Like,               'posterous/models/like'
  autoload :Link,               'posterous/models/link'
  autoload :LinkCategory,       'posterous/models/link_category'
  autoload :ExternalSite,       'posterous/models/external_site'
  autoload :Subscriber,         'posterous/models/subscriber'
  autoload :Subscription,       'posterous/models/subscription'
  autoload :AssociationProxy,   'posterous/association_proxy'


  def config=(cfg)
    @config = case
      when cfg.is_a?(String)
        YAML.load_file(cfg)
      when cfg.is_a?(Hash)
        cfg
      else
        raise ArgumentError, 'Invalid Config'
    end
  end
end


