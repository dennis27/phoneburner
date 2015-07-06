module Phoneburner
  class Call < Phoneburner::Model

    def self.path
      "/rest/1/dialsession/call/"
    end

    def self.json_type
      "call"
    end

    def id
      self.call_id
    end

    def id=(i)
      self.call_id = i
    end

  end
end