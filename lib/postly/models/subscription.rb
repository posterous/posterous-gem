module Postly
  class Subscription < Postly::Model
    parent    :user_id
    resource  "/users/:user_id/subscriptions"

    def self.posts params={}
      get(parsed_resource_url + '/posts',params).collect{|p| Post.new(p) }
    end
  end
end
