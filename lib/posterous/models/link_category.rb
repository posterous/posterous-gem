module Posterous
  class LinkCategory < Posterous::Model
    parent    :site_id
    resource  "/sites/:site_id/link_categories"

    many :links, Link
  end
end
