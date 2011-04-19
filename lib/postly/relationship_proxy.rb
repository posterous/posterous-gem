module Postly
  class RelationshipProxy
    attr_reader :klass, :proxied

    instance_methods.each { |m| undef_method m unless m.to_s =~ /^(?:nil\?|send|object_id|to_a)$|^__|^respond_to|proxy_/ }
    
    def initialize proxied, klass, association_type, *args
      @association_klass  = klass
      @proxied            = proxied
      @association        = nil

      @association_klass.finder_opts[klass.parent_resource] = proxied.id
      @association_klass.finder_opts.merge!(@proxied.finder_opts)

      load_method   =  association_type == :many ? :all : :load
      @association  = @association_klass.send(load_method, *args)
    end

    def method_missing sym, *args, &block
      [@association, @association_klass].each do |assoc|
        return assoc.send(sym, *args, &block) if assoc.respond_to?(sym)
      end
      super(sym, *args, &block)
    end
    
    def respond_to?(*args)
      [@association, @association_klass].any?{|a| a.respond_to?(*args) }
    end
     
  end
end
