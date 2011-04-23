module Posterous
  class Subscriber < Posterous::Model
    parent    :site_id
    resource  "/sites/:site_id/subscribers"
  end
end
