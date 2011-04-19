module Postly
  class User < Postly::Model
    resource  "/users/"

    def self.me
      find('me')
    end
  end
end

