module Postly
  class Subscriber < Postly::Model
    parent    :site_id
    resource  "/sites/:site_id/subscribers"
  end
end
