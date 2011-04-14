module Postly

  class Site < Postly::Model
    
    many :posts, :Post

    def self.find id_or_hostname
      new get( "/sites/#{id_or_hostname}")
    end

    def self.create params={}
      new post('/sites', :site => params)
    end

    def self.all params={}
      @sites ||= get("/sites",params).collect{|s| self.new(s) }
    end

    def save
      return if hash_for_update.empty?
      @struct = self.class.post("/sites/#{self.id}", '_method' => 'put', :site => hash_for_update )
      changed_fields.clear
    end

    def destroy
      self.class.post("/sites/#{self.id}", '_method' => 'delete')
    end

  end
end
