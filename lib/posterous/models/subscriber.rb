module Posterous
  class Subscriber < Posterous::Model
    resource  "/sites/:site_id/subscribers"
  end
end
