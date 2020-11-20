module Moodle2CC::Moodle2::Models
  class Checklist
    attr_accessor :id, :module_id, :name, :context_id, :max_grade, :completion_percent,
                  :items

    def initialize
      @items = []
    end

    class Question
      attr_accessor :id, :display_text, :position, :optional
    end
  end
end