module Phoneburner
  class Model

    def initialize(client, attrs={})    
      @client = client   
      attributes(attrs)
    end

    def attributes(attrs)
      @attrs = Hash[attrs.map do |k, v| 
        if v.is_a?(Hash)
          [k.to_s, Phoneburner::Model.new(client,v)]
        else
          [k.to_s, v]
        end
      end]
      nil
    end

    def <=>(other)
      self.id <=> other.id
    end

    def self.secondary_json_type(request)
      self.json_type
    end

    def self.extract_results(results, request)
      results[self.json_type]
    end

    def self.extract_inner_results(results, request)
      results[self.secondary_json_type(request)]
    end

    def path
      self.class.path
    end

    def attribute_names
      @attrs.keys
    end

    def method_missing(symbol,*args)
      if symbol.to_s.end_with?("=")        
        @attrs[symbol.to_s.gsub!(/=$/,'')] = args.first
      else
        @attrs[symbol.to_s]
      end
    end

    def to_json
      @attrs.to_json
    end

    def is_new?
      !!self.id
    end

    def refresh
      unless is_new?
        Phoneburner::Request.new(@client,self.class).find(self.id).raw.result do |r|
          attributes(r)
        end
      end
    end

    def delete
      unless is_new?
        Phoneburner::Request.new(@client,self.class).delete(self.id)
        #FIXME What should we do here
      end
    end

    def save
      if is_new?
        Phoneburner::Request.new(@client,self.class).create(self).raw.result do |r|
          update_attributes(r)
        end
      else
        Phoneburner::Request.new(@client,self.class).update(self.id,self).raw.result do |r|
          update_attributes(r)
        end
      end
    end

  private
    def update_attributes(attrs)
      attrs.each do |k, v| 
        @attrs[k.to_s] = v.is_a?(Hash) ? Phoneburner::Model.new(client,v)] : v
      end
      nil
    end

  end
end