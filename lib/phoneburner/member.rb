module Phoneburner
  class Member < Phoneburner::Model

    def self.path
      "/rest/1/members/"
    end

    def self.json_type
      "members"
    end

    def id
      self.user_id
    end

    def id=(i)
      self.user_id = i
    end

    def self.extract_inner_results(results, request)
      r = super(results,request)
      if r.is_a?(Array)
        if r.first.is_a?(Array)
          r = r.flatten
        end
      end
      r
    end

  end
end