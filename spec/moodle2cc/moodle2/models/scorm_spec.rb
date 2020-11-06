require 'spec_helper'

describe Moodle2CC::Moodle2::Models::Scorm do

  it_behaves_like 'it has an attribute for', :id
  it_behaves_like 'it has an attribute for', :module_id
  it_behaves_like 'it has an attribute for', :name
  it_behaves_like 'it has an attribute for', :contextid
  it_behaves_like 'it has an attribute for', :reference_filename
  it_behaves_like 'it has an attribute for', :reference_hash
  it_behaves_like 'it has an attribute for', :version
  it_behaves_like 'it has an attribute for', :file_ids, []

end
