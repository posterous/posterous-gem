module Postly
  class Profile < Postly::Model
    parent    :site_id
    resource  "/sites/:site_id/profile"
  end
end
