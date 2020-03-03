# frozen_string_literal: true

qa_support :shared_examples

RSpec.shared_examples 'a full netsuite soap resource' do
  it_behaves_like 'a create', delete: false
  # it_behaves_like 'a delete', delete: false
  it_behaves_like 'a find', delete: false
  # it_behaves_like 'an update', delete: false
end
