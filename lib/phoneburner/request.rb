module Phoneburner
  class Request

    def initialize(client,model) 
      @model = model
      @client = client
      @token = client.token
      @url = client.url 
      @query_params = {}
    end

    attr_reader :client, :model

    def method_missing(symbol,*args)
      if args.size > 0
        @query_params[symbol.to_s] = args.first
        self
      else
        @query_params[symbol.to_s]
      end      
    end

    def clear
      @query_params={}
    end

    def initialize_copy(orig)
      super
      @query_params = @query_params.dup
    end

    def find(id)
      Phoneburner::Response.new(self) do
        puts "#{@url}#{@model.path}#{id}"
        RestClient.get "#{@url}#{@model.path}#{id}", {:Authorization => "Bearer #{@token}"}
      end
    end

    def build(attrs={})
      @model.new(client,attrs)
    end

    def create(obj_or_hash_or_json)      
      Phoneburner::Response.new(self) do
        RestClient.post "#{@url}#{@model.path}", as_json(obj_or_hash_or_json), {:Authorization => "Bearer #{@token}",:content_type => :json, :accept => :json}
      end
    end

    def create!(obj_or_hash_or_json)      
      Phoneburner::Response.new(self) do
        RestClient.post "#{@url}#{@model.path}", as_json(obj_or_hash_or_json), {:Authorization => "Bearer #{@token}",:content_type => :json, :accept => :json}
      end.result
    end

    def update(id,obj_or_hash_or_json)
      Phoneburner::Response.new(self) do
        RestClient.put "#{@url}#{@model.path}#{id}", as_json(obj_or_hash_or_json), {:Authorization => "Bearer #{@token}",:content_type => :json, :accept => :json}
      end
    end

    def delete(id)
      Phoneburner::Response.new(self) do
        RestClient.delete "#{@url}#{@model.path}#{id}", {:Authorization => "Bearer #{@token}",:content_type => :json, :accept => :json}
      end
    end

    def delete!(id)
      Phoneburner::Response.new(self) do
        RestClient.delete "#{@url}#{@model.path}#{id}", {:Authorization => "Bearer #{@token}",:content_type => :json, :accept => :json}
      end.http_status
      nil
    end

    def all()
      Phoneburner::Response.new(self) do
        RestClient.get "#{@url}#{@model.path}", {:Authorization => "Bearer #{@token}",:params=>@query_params,:accept => :json}
      end
    end

  private
    def as_json(obj_or_hash_or_json)
      if obj_or_hash_or_json.is_a?(String)
        obj_or_hash_or_json
      elsif obj_or_hash_or_json.respond_to?(:to_json)
        obj_or_hash_or_json.to_json
      end
    end

  end 
end