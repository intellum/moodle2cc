module Moodle2CC::Moodle2::Parsers
  class ChecklistParser
    include ParserHelper

    CHECKLIST_XML = 'checklist.xml'
    LABEL_MODULE_NAME = 'checklist'

    def initialize(backup_dir)
      @backup_dir = backup_dir
    end

    def parse
      activity_dirs = activity_directories(@backup_dir, LABEL_MODULE_NAME)
      activity_dirs.map { |dir| parse_checklist(dir) }
    end

    private

    def parse_checklist(dir)
      checklist = Moodle2CC::Moodle2::Models::Checklist.new
      activity_dir = File.join(@backup_dir, dir)
      File.open(File.join(activity_dir, CHECKLIST_XML)) do |f|
        checklist_xml = Nokogiri::XML(f)
        checklist.id = checklist_xml.at_xpath('/activity/checklist/@id').value
        checklist.module_id = checklist_xml.at_xpath('/activity/@moduleid').value
        checklist.context_id = parse_text(checklist_xml, '/activity/@contextid')
        checklist.name = parse_text(checklist_xml, '/activity/checklist/name')
        checklist.max_grade = parse_text(checklist_xml, '/activity/checklist/maxgrade')
        checklist.completion_percent = parse_text(checklist_xml, '/activity/checklist/completionpercent')

        checklist_xml.search('activity/checklist/items/item').each do |node|
          item = Moodle2CC::Moodle2::Models::Checklist::Question.new
          item.id = node.attributes['id'].value
          item.display_text = parse_text(node, 'displaytext')
          item.position = parse_text(node, 'position')
          item.optional = parse_text(node, 'itemoptional')

          checklist.items << item
        end
        checklist.items.sort_by!{|q| q.position.to_i}
      end
      checklist
    end
  end
end
