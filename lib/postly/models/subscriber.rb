module Postly
  class Subscriber < Postly::Model
    parent    :site_id
    resource  "/sites/:site_id/subscribers"
  end


  def destroy
    self.class.delete(parsed_resource_url + "/#{sid}")
  end

end
