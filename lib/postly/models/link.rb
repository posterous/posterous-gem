module Postly
  class Link < Postly::Model
    parent    :link_category_id
    resource  "/sites/:site_id/link_categories/:link_category_id"
  end
end