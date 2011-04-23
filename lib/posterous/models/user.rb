module Posterous
  class User < Posterous::Model
    resource  "/users"
    many :subscriptions, Subscription

    def self.me
      find('me')
    end

    def favorites
      self.class.get("/users/#{self.id}/favorites").collect{|f| Post.new(f) }
    end

    def likes
      self.class.get("/users/#{self.id}/likes").collect{|f| Like.new(f) }
    end
  end
end

