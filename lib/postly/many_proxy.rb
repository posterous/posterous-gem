module Postly

  class ManyProxy
    attr_reader :klass, :proxied
    def initialize proxied, klass
      @klass              = klass
      @proxied            = proxied

      @klass.finder_opts[klass.parent_resource] = proxied.id
      @klass.finder_opts.merge!(@proxied.finder_opts)
    end

    def method_missing sym, *args, &block
      if klass.respond_to? sym
        return klass.send(sym,*args, &block)
      end
      super(sym, *args, &block)
    end
  end

end
