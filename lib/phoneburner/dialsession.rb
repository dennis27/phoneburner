module Phoneburner
  class Dialsession < Phoneburner::Model

    def self.path
      "/rest/1/dialsession/"
    end

    def self.json_type
      "dialsessions"
    end

    def id
      self.dialsession_id
    end

    def id=(i)
      self.dialsession_id = i
    end

  end
end