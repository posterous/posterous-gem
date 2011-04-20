module Postly
  class Tag < Postly::Model
    parent    :site_id
    resource  "/sites/:site_id/tags"
  end
end
