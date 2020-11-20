require 'spec_helper'

module Moodle2CC::Moodle2::Parsers
  describe ChecklistParser do

    it 'should parse checklists' do
      checklist_parser = Moodle2CC::Moodle2::Parsers::ChecklistParser.new(fixture_path(File.join('moodle2', 'backup')))
      checklists = checklist_parser.parse
      checklist = checklists.find{|ch| ch.id == '1052'}
      expect(checklist.id).to eq('1052')
      expect(checklist.module_id).to eq('15997')
      expect(checklist.name).to eq('Sample Checklist')
      expect(checklist.context_id).to eq('69406')
      expect(checklist.max_grade).to eq('100')
      expect(checklist.completion_percent).to eq('100')

      expect(checklist.items.count).to eq(1)
      item = checklist.items.last
      expect(item.id).to eq '14921'
      expect(item.display_text).to eq 'I, the instructor, confirm that he/she has successfully completed the entire certification program.'
    end

  end
end