module Postly

  class ManyProxy
    def initialize proxied, klass
      @klass    = klass
      @proxied  = proxied
    end
    
    def all params={}
      @klass.all( @proxied.id, params )
    end    

    def create params={}
      @klass.create( @proxied.id, params )
    end
  end

end
