module Posterous
  class User < Posterous::Model
    resource  "/users"
    many :subscriptions, Subscription

    def self.me
      find('me')
    end

    def save
     @resp = self.class.post("/users/#{self.id}/profile", {:user => hash_for_update, '_method' => 'put'})
     changed_fields.clear
    end

    def favorites
      self.class.get("/users/#{self.id}/favorites").collect{|f| Post.new(f) }
    end

    def likes
      self.class.get("/users/#{self.id}/likes").collect{|f| Like.new(f) }
    end
  end
end

