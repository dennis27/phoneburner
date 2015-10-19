require "phoneburner/version"
require "phoneburner/client"
require "phoneburner/model"
require "phoneburner/request"
require "phoneburner/response"
require "phoneburner/contact"
require "phoneburner/member"
require "phoneburner/content"
require "phoneburner/dialsession"
require "phoneburner/folder"
require "phoneburner/settings"
require "phoneburner/voicemail"
require "phoneburner/call"


require "rest-client"

module Phoneburner
  
  def self.client(api_token,opts={})
    Phoneburner::Client.new(api_token,opts)
  end
  
end
