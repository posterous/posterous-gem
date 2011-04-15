module Postly
  class LinkCategory < Postly::Model
    parent    :site_id
    resource  "/sites/:site_id/link_categories"
  end
end
