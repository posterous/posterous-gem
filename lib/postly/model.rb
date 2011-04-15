module Postly
  module Inheritable

    def self.included klass
      klass.class_eval do
        extend ClassMethods
      end  
    end

    module ClassMethods
      def inherited_attributes(*args)
        @inherited_attributes ||= [:inherited_attributes]
        @inherited_attributes += args
        args.each do |arg|
          class_eval %(
            class << self; attr_accessor :#{arg} end
          )
        end
        @inherited_attributes
      end

      def inherited(subclass)
        @inherited_attributes.each do |inheritable_attribute|
          instance_var = "@#{inheritable_attribute}"
          subclass.instance_variable_set(instance_var, instance_variable_get(instance_var))
        end
      end
    end

  end

  class Model
    include Inheritable
    extend Connection
    
    attr_reader :struct, :resource_url

    inherited_attributes :finder_opts, :parent_resource, :resource_path
    @finder_opts ||= {} 

    def self.many collection_name, klass
      define_method collection_name do
        ManyProxy.new self, klass
      end
    end

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
      self.to_s.split('::').last.downcase.to_sym
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
      resource_path.gsub(/:\w+/) {|sym| finder_opts[sym.sub(/:/,'').to_sym] }
    end

    def self.resource path
      @resource_path = path
    end

    def self.parent sym
      @parent_resource = sym
    end

    def resource_path
      self.class.resource_path
    end

    def parent_resource
      self.class.parent_resource
    end
    
    def finder_opts
      self.class.finder_opts
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
