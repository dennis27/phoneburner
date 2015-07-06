module Phoneburner
  class Voicemail < Phoneburner::Model

    def self.path
      "/rest/1/voicemails/"
    end

    def self.json_type
      "voicemails"
    end

    def id
      self.recording_id
    end

    def id=(i)
      self.recording_id = i
    end

  end
end