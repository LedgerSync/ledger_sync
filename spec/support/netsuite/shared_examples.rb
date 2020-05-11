# frozen_string_literal: true

support :operation_shared_examples
support :netsuite_helpers

RSpec.shared_examples 'a netsuite operation' do
  include NetSuiteHelpers

  let(:resource) { FactoryBot.create(record) } unless method_defined?(:resource)
  let(:adaptor) { netsuite_adaptor } unless method_defined?(:adaptor)
  unless method_defined?(:record)
    let(:record) do
      described_class.inferred_resource_class.resource_type.to_s
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
        resource.ledger_id = netsuite_records.send(record).hash['id']
        stub_delete_for_record
      when :find
        resource.ledger_id = netsuite_records.send(record).hash['id']
        stub_find_for_record
      when :update
        resource.ledger_id = netsuite_records.send(record).hash['id']
        stub_find_for_record
        stub_update_for_record
      end
    end

    it_behaves_like 'a successful operation'
  end
end

RSpec.shared_examples 'a netsuite searcher' do
  include NetSuiteHelpers

  let(:adaptor) { netsuite_adaptor } unless method_defined?(:adaptor)
  let(:resource_class) { described_class.inferred_resource_class } unless method_defined?(:resource_class)
  unless method_defined?(:record)
    let(:record) do
      resource_class.resource_type.to_s
    end
  end
  let(:input) do
    {
      adaptor: adaptor,
      query: ''
    }
  end

  before do
    stub_search_for_record
  end

  describe '#resources' do
    subject { described_class.new(**input).search.resources }

    it { expect(subject.count).to eq(2) }
    it { expect(subject.first).to be_a(resource_class) }
  end

  describe '#search' do
    subject { described_class.new(**input).search }

    it { expect(subject).to be_success }
    it { expect(subject).to be_a(LedgerSync::SearchResult::Success) }
  end
end
