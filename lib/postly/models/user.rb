module Postly
  class User < Postly::Model
    resource  "/users"
    many :subscriptions, Subscription

    def self.me
      find('me')
    end

    def favorites
      self.class.get("/users/#{self.id}/favorites").collect{|f| Post.new(f) }
    end
  end
end

