module Postly
  class Model

    extend Postly::Connection

    attr_reader :struct

    def self.many collection_name, klass
      define_method collection_name do
        return ManyProxy.new self, klass
      end
    end
  
    def initialize struct
      @struct = struct
    end

    def reload
      self.class.find(self.id)
    end

    def changed_fields
      @changed_fields ||= []
    end

    def hash_for_update
      Hash[changed_fields.collect{ |f| [f, self.send(f)] }]
    end

    def method_missing sym, *args, &block
      if struct.respond_to? sym
        changed_fields.push(sym.to_s.sub('=','').to_sym) if sym.to_s =~ /=/
        return struct.send(sym,*args)
      end
      super(sym, *args, &block)
    end   

  end
end
