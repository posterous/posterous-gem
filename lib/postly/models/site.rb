module Postly
  class Site < Postly::Model
    resource "/sites"

    one  :profile,          Profile
    many :posts,            Post
    many :pages,            Page
    many :link_categories,  LinkCategory    
  end
end
