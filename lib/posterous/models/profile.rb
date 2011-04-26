module Posterous
  class Profile < Posterous::Model
    resource  "/sites/:site_id/profile"

    def self.param_scope
      'site_profile'
    end

    def save
      return if hash_for_update.empty?
      @struct = self.class.post(parsed_resource_url, { param_scope => hash_for_update, '_method' => 'put' } )
      changed_fields.clear
    end

    def destroy
      self.class.delete(parsed_resource_url)
    end
  end
end
