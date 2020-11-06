module Moodle2CC::Moodle2::Models
  class Scorm
    attr_accessor :id, :module_id, :name, :contextid, :reference_filename,
                  :reference_hash, :version, :file_ids

    def initialize
      @file_ids = []
    end

  end
end