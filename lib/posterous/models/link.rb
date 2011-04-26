module Posterous
  class Link < Posterous::Model
    resource  "/sites/:site_id/link_categories/:link_category_id/links"
  end
end
