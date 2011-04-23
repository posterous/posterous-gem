module Posterous
  class Post < Posterous::Model
    parent    :site_id
    resource  "/sites/:site_id/posts"

    many      :comments, Comment
    many      :likes,    Like
  end
end
