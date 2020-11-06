module Moodle2CC::Moodle2::Parsers
  class ScormParser
    include ParserHelper

    SCORM_XML = 'scorm.xml'
    LABEL_MODULE_NAME = 'scorm'

    def initialize(backup_dir)
      @backup_dir = backup_dir
    end

    def parse
      activity_dirs = activity_directories(@backup_dir, LABEL_MODULE_NAME)
      activity_dirs.map { |dir| parse_scorm(dir) }
    end

    private

    def parse_scorm(dir)
      scorm = Moodle2CC::Moodle2::Models::Scorm.new
      activity_dir = File.join(@backup_dir, dir)
      File.open(File.join(activity_dir, SCORM_XML)) do |f|
        scorm_xml = Nokogiri::XML(f)
        scorm.id = scorm_xml.at_xpath('/activity/scorm/@id').value
        scorm.module_id = scorm_xml.at_xpath('/activity/@moduleid').value
        scorm.contextid = parse_text(scorm_xml, '/activity/@contextid')
        scorm.name = parse_text(scorm_xml, '/activity/scorm/name')
        scorm.reference_filename = parse_text(scorm_xml, '/activity/scorm/reference')
        scorm.reference_hash = parse_text(scorm_xml, '/activity/scorm/sha1hash')
        scorm.version = parse_text(scorm_xml, '/activity/scorm/version')
      end
      scorm.file_ids += parse_files(dir)
      scorm
    end

    def parse_files(dir)
      files = []
      File.open(File.join(@backup_dir, dir, FILES_XML)) do |f|
        xml = Nokogiri::XML(f)
        xml.search('/inforef/fileref/file').each do |node|
          files << parse_text(node, 'id')
        end
      end
      files
    end

  end
end