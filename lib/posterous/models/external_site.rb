module Posterous
  class ExternalSite < Posterous::Model
    resource  "/sites/:site_id/external_sites"
  end
end
