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

  end
end