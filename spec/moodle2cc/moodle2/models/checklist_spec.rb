require 'spec_helper'

describe Moodle2CC::Moodle2::Models::Checklist do

  it_behaves_like 'it has an attribute for', :id
  it_behaves_like 'it has an attribute for', :module_id
  it_behaves_like 'it has an attribute for', :name
  it_behaves_like 'it has an attribute for', :context_id
  it_behaves_like 'it has an attribute for', :max_grade
  it_behaves_like 'it has an attribute for', :completion_percent
  it_behaves_like 'it has an attribute for', :items, []

end
