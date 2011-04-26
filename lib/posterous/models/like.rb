module Posterous
  class Like < Posterous::Model
    resource  "/sites/:site_id/posts/:post_id/likes"
  end
end
