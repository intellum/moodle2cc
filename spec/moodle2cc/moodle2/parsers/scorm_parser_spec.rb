require 'spec_helper'

module Moodle2CC::Moodle2::Parsers
  describe ScormParser do

    it 'should parse scorms' do
      scorm_parser = Moodle2CC::Moodle2::Parsers::ScormParser.new(fixture_path(File.join('moodle2', 'backup')))
      scorms = scorm_parser.parse
      scorm = scorms.find{|s| s.id == '158'}
      expect(scorm.id).to eq('158')
      expect(scorm.module_id).to eq('15962')
      expect(scorm.name).to eq('Sample Scorm')
      expect(scorm.contextid).to eq('69187')
      expect(scorm.reference_filename).to eq('01_CWP_v2_04282020.zip')
      expect(scorm.reference_hash).to eq('f54af8f7bde0838b200cc76cfd49aa6f2ee35509')
      expect(scorm.version).to eq('SCORM_1.2')
      expect(scorm.file_ids).to eq(['288916', '288915'])
    end

  end
end