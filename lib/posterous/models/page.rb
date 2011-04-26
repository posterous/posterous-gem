module Posterous
  class Page < Posterous::Model
    resource  "/sites/:site_id/pages"
  end
end
