module Phoneburner
  class Content < Phoneburner::Model

    def self.path
      "/rest/1/content/"
    end

    def self.json_type
      "content"
    end

    def self.secondary_json_type(request)
      "emails"
    end

    def id
      self.cm_content_id
    end

    def id=(i)
      self.cm_content_id = i
    end

  end
end