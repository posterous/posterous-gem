module Posterous
  class Profile < Posterous::Model
    resource  "/sites/:site_id/profile"

    def self.param_scope
      'site_profile'
    end

    def instance_url
      parsed_resource_url
    end

  end
end
