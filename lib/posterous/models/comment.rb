module Posterous
  class Comment < Posterous::Model
    resource  "/sites/:site_id/posts/:post_id/comments"
  end
end
