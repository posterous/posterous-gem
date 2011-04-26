module Posterous
  class Tag < Posterous::Model
    resource  "/sites/:site_id/tags"
  end
end
