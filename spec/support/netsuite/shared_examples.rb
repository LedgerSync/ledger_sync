# frozen_string_literal: true

support :operation_shared_examples
support :netsuite_helpers

RSpec.shared_examples 'a netsuite operation' do
  include NetSuiteHelpers

  let(:resource) { FactoryBot.create(record) } unless method_defined?(:resource)
  let(:adaptor) { netsuite_adaptor } unless method_defined?(:adaptor)
  unless method_defined?(:record)
    let(:record) do
      adaptor.class.ledger_resource_type_for(resource_class: described_class.inferred_resource_class)
    end
  end

  before do
    case described_class.operation_method
    when :delete
      resource.ledger_id = netsuite_records.send(record).hash['id']
    when :find
      resource.ledger_id = netsuite_records.send(record).hash['id']
    when :update
      resource.ledger_id = netsuite_records.send(record).hash['id']
    end
  end

  it_behaves_like 'a valid operation'

  context do
    before do
      case described_class.operation_method
      when :create
        stub_find_for_record
        stub_create_for_record
      when :delete
        stub_delete_for_record
      when :find
        stub_find_for_record
      when :update
        stub_find_for_record
        stub_update_for_record
      end
    end

    it_behaves_like 'a successful operation'
  end
end
