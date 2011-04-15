module Postly
  class Model
    include Inheritable
    extend Connection
    
    attr_reader :struct

    def self.all params={}
      get( parsed_resource_url, params ).collect{|s| self.new(s) }
    end

    def self.find mid
      new get( parsed_resource_url + "/#{mid}")
    end

    def self.create params={}
      new post(parsed_resource_url, param_scope => params)
    end

    def self.param_scope
      underscore(self.to_s.split('::').last).to_sym
    end

    def self.underscore(camel_cased_word)
      camel_cased_word.to_s.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
    end
    

    def param_scope
      self.class.param_scope
    end
    
    def save
      return if hash_for_update.empty?
      @struct = self.class.post(parsed_resource_url + "/#{self.id}", { param_scope => hash_for_update, '_method' => 'put' } )
      changed_fields.clear
    end

    def destroy
      self.class.delete(parsed_resource_url + "/#{self.id}")
    end

    def reload
      self.class.find(self.id)
    end

    def self.parsed_resource_url
      resource_path.gsub(/:\w+/) {|sym| finder_opts[sym.sub(/:/,'').to_sym] }
    end

    def parsed_resource_url
      self.class.parsed_resource_url     
    end
        
    def initialize struct
      @struct = struct
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
