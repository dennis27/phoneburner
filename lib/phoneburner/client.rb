module Phoneburner
  class Client

    attr_accessor :token

    def initialize(token) 
      @token = token
    end

    def contacts
      Phoneburner::Request.new(self,Phoneburner::Contact)
    end

    def members
      Phoneburner::Request.new(self,Phoneburner::Member)
    end

    def dialsessions
      Phoneburner::Request.new(self,Phoneburner::Dialsession)
    end

    def calls
      Phoneburner::Request.new(self,Phoneburner::Call)
    end

    def dialsession_settings
      Phoneburner::Request.new(self,Phoneburner::Settings)
    end

    def folders
      Phoneburner::Request.new(self,Phoneburner::Folder)
    end

    def voicemails
      Phoneburner::Request.new(self,Phoneburner::Voicemail)
    end





  end
end