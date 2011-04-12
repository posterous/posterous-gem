module Postly
  class Site
    extend Postly::Connection

    attr_reader :struct

    def self.find id_or_hostname
      new get( "/sites/#{id_or_hostname}")
    end

    def self.create params={}
      new post('/sites', :site => params)
    end

    def self.all params={}
      @sites ||= get("/sites",params).collect{|s| self.new(s) }
    end

    def initialize struct
      @struct = struct
    end

    def save params={}
      @struct = self.class.put("/sites/#{self.id}", :site => params)
    end

    def method_missing sym, *args, &block
      return struct.send(sym) if struct.respond_to? sym
      super(sym, *args, &block)
    end
  end
end
