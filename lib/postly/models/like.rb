module Postly
  class Like < Postly::Model
    parent    :post_id
    resource  "/sites/:site_id/posts/:post_id/likes"
  end
end
