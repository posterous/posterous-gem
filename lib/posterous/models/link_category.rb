module Posterous
  class LinkCategory < Posterous::Model
    resource  "/sites/:site_id/link_categories"

    many :links, Link
  end
end
