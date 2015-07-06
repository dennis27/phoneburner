module Phoneburner
  class Settings < Phoneburner::Model

    def self.path
      "/rest/1/dialsession/settings"
    end

    def self.json_type
      "settings"
    end

    def id
      nil
    end

    def id=(i)
      
    end

  end
end