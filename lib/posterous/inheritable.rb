module Posterous
  module Inheritable

    def self.included klass
      klass.class_eval do
        extend ClassMethods
        include InstanceMethods

        inherited_attributes :finder_opts, :parent_resource, :resource_path
        @finder_opts ||= {} 
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

      def resource path
        @resource_path = path
      end

      def parent sym
        @parent_resource = sym
      end

      def many collection_name, klass
        define_method collection_name do |*args|
          AssociationProxy.new self, klass, :many, *args
        end
      end

      def one collection_name, klass
        define_method collection_name do |*args|
          AssociationProxy.new self, klass, :one, *args
        end
      end

    end

    module InstanceMethods
      def resource_path
        self.class.resource_path
      end

      def parent_resource
        self.class.parent_resource
      end
      
      def finder_opts
        self.class.finder_opts
      end
    end

  end
end
