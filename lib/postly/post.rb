module Postly

  class Post < Postly::Model

    def self.find site_id_or_hostname, post_id, params={}
      new get( "/sites/#{site_id_or_hostname}/posts/#{post_id}",params)
    end

    def self.create site_id_or_hostname, params={}
      new post("/sites/#{site_id_or_hostname}/posts", :post => params)
    end

    def self.all site_id_or_hostname, params={}
      @posts ||= get("/sites/#{site_id_or_hostname}/posts",params).collect{|s| self.new(s) }
    end

    def save
      return if hash_for_update.empty?
      @struct = self.class.put("/sites/#{self.site_id}/posts/#{self.id}", :post => hash_for_update )
      changed_fields.clear
    end

    def destroy
      self.class.delete("/sites/#{self.site_id}/posts/#{self.id}")
    end

    def reload
      self.class.find(self.site_id, self.id)
    end
  end
end
