module Postly
  class Model
    include Inheritable
    extend Connection
    
    attr_reader :struct

    # Get a collection for a model
    #
    # Site.posts.all(:page => 1)
    def self.all params={}
      result = get( parsed_resource_url, params )
      result.collect{|s| self.new(s) }
    end

    # Get a model from a collection by its id.
    #
    # Site.primary.posts.find(123)
    # Site.find(123)
    def self.find mid
      new get( parsed_resource_url + "/#{mid}")
    end

    # loads the model data from the server and
    # instantiates a new instance of its class
    #
    # Site.primary.profile.load
    def self.load
      new get(parsed_resource_url) rescue self.new(OpenStruct.new)
    end

    # Used to scope query params for a given model
    #
    # Posterous::ExternalSite => external_site
    def self.param_scope
      underscore(self.to_s.split('::').last).to_sym
    end

    def param_scope
      self.class.param_scope
    end
    
    # lifted from ActiveSupport.
    def self.underscore(camel_cased_word)
      camel_cased_word.to_s.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
    end

    # Creates a new model with the given params.
    # Converts a :media array into a hash to make
    # the Rails app happy.
    #
    # Site.primary.posts.create(:title => 'Awesome!', :media => [File.open('../some/path')])
    def self.create params={}
      media_array = params.delete(:media)
      media       = Hash[media_array.each_with_index.map{|v,i| [i,v] }] unless media_array.nil?

      new post(parsed_resource_url, param_scope => params, :media => media)
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

    def respond_to? *args
      struct.respond_to?(*args) || super
    end

    def method_missing sym, *args, &block
      if struct.respond_to? sym
        changed_fields.push(sym.to_s.sub('=','').to_sym) if sym.to_s =~ /=/
        return struct.send(sym,*args)
      end
      super(sym, *args, &block)
    end   

    def inspect
      "<#{self} #{struct.send(:table).to_s}>"
    end

  end
end
