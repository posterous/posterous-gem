module Postly
  class Site < Postly::Model
    resource "/sites"

    one  :profile,          Profile
    many :posts,            Post
    many :pages,            Page
    many :link_categories,  LinkCategory    
    many :external_sites,   ExternalSite

    def self.primary
      find('primary')
    end
    
  end
end
