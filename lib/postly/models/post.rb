module Postly
  class Post < Postly::Model
    parent    :site_id
    resource  "/sites/:site_id/posts"
    many      :comments, Comment
    many      :likes,    Like
  end
end
