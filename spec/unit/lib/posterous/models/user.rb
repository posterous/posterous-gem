module Posterous
  class User < Posterous::Model
    resource  "/users/"

    def self.me
      find('me')
    end
  end
end

