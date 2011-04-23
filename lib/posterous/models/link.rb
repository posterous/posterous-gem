module Posterous
  class Link < Posterous::Model
    parent    :link_category_id
    resource  "/sites/:site_id/link_categories/:link_category_id/links"
  end
end
