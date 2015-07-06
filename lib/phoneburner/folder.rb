module Phoneburner
  class Folder < Phoneburner::Model

    def self.path
      "/rest/1/folders/"
    end

    def self.json_type
      "folders"
    end

    def id
      self.folder_id
    end

    def id=(i)
      self.folder_id = i
    end

    def self.extract_inner_results(results, request)
      _results = []
      results.each {|i,h| _results << h if h.is_a?(Hash) }      
      _results
    end

  end
end