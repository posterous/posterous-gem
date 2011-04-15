module Postly
  class Page < Postly::Model
    parent    :site_id
    resource  "/sites/:site_id/pages"
  end
end
