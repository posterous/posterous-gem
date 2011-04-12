module Postly

  class ManyProxy
    def initialize proxied, klass
      @klass    = klass
      @proxied  = proxied
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
