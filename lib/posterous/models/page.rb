module Posterous
  class Page < Posterous::Model
    parent    :site_id
    resource  "/sites/:site_id/pages"
  end
end
