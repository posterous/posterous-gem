module Postly
  class ExternalSite < Postly::Model
    parent    :site_id
    resource  "/sites/:site_id/external_sites"
  end
end
