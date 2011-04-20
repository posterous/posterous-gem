module Postly
  class Site < Postly::Model
    resource "/sites"

    one  :profile,          Profile
    many :tags,             Tag
    many :posts,            Post
    many :pages,            Page
    many :link_categories,  LinkCategory    
    many :external_sites,   ExternalSite
    many :subscribers,      Subscriber

    def self.primary
      find('primary')
    end

    def photos
      self.class.get(parsed_resource_url + "#{self.id}/photos")
    end
    
  end
end
