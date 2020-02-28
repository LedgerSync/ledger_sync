# frozen_string_literal: true

qa_support :shared_examples

RSpec.shared_examples 'a full stripe resource' do
  it_behaves_like 'a create'
  it_behaves_like 'a delete'
  it_behaves_like 'a find'
  it_behaves_like 'an update'
end
