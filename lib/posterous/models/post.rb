module Posterous
  class Post < Posterous::Model
    resource  "/sites/:site_id/posts"

    many      :comments, Comment
    many      :likes,    Like
  end
end
