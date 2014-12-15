require 'rom'
require 'rom/adapter/memory/dataset'

# ?? require 'json'

module ROM

  class ApiAdapter < Adapter
    # TODO: This is just a copy-paste from the Github demo
    # https://github.com/solnic/rom-demo/blob/master/lib/github_adapter.rb
    #
    # However it looks like this is more of a Proxy-Service than an adapter?
    #
    # ... looks like I need a HashAdapter for all my CustomerAdapters, ??? 
    # my sense of the 'adapter' pattern seems to gravitate towards
    # CustomerAdapter to define transformations or "views of the same object",
    # while HashAdapter seems another type of pattern?
    #
    
    attr_reader :resources

    class Resource
      include Enumerable

      attr_reader :connection, :path

      def initialize(connection, path)
        @connection = connection
        @path = path
      end

      def each(&block)
        JSON.parse(connection.get(path).body).each(&block)
      end
    end

    class Dataset < Adapter::Memory::Dataset
      include Charlatan.new(:data, kind: Array)

      def self.build(*args)
        new(Resource.new(*args))
      end
    end

    def self.schemes
      [:github]
    end

    def initialize(uri)
      super
      @connection = Faraday.new(url: "https://api.github.com/#{uri.host}#{uri.path}")
      @resources = {}
    end

    def [](name)
      @resources[name] ||= Dataset.build(connection, name.to_s)
    end

    def dataset?(name)
      resources.key?(name)
    end

    Adapter.register(self)
  end


