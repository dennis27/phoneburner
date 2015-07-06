module Phoneburner
  class Contact < Phoneburner::Model

    def self.path
      "/rest/1/contacts/"
    end

    def self.json_type
      "contacts"
    end

    def id
      self.contact_id
    end

    def id=(i)
      self.contact_id = i
    end

  end
end