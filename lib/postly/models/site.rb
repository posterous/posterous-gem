module Postly
  class Site < Postly::Model
    resource "/sites"

    one  :profile,          Profile
    many :posts,            Post
    many :pages,            Page
    many :link_categories,  LinkCategory    

    def self.primary
      find('primary')
    end
    def self.first
      find('first')
    end
  end
end
