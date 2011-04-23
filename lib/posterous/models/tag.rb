module Posterous
  class Tag < Posterous::Model
    parent    :site_id
    resource  "/sites/:site_id/tags"
  end
end
