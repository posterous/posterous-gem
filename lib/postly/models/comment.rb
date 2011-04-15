module Postly
  class Comment < Postly::Model
    parent    :post_id
    resource  "/sites/:site_id/posts/:post_id/comments"
  end
end
