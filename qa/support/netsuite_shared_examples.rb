# frozen_string_literal: true

support :shared_examples

RSpec.shared_examples 'a record with metadata' do
  describe LedgerSync::Adaptors::NetSuite::Record::Metadata do
    subject do
      described_class.new(
        adaptor: adaptor,
        record: record
      )
    end

    context '.http_methods' do
      it { expect(subject.http_methods.count).not_to be_zero }
    end

    context '.properties' do
      it { expect(subject.properties.count).not_to be_zero }
    end
  end
end

RSpec.shared_examples 'a full netsuite resource' do
  it_behaves_like 'a create'
  it_behaves_like 'a delete'
  it_behaves_like 'a find'
  it_behaves_like 'an update'
  it_behaves_like 'a record with metadata'
end
