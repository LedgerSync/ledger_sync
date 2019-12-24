# frozen_string_literal: true

RSpec.shared_examples 'a netsuite create' do
  it do
    result = create_result_for(
      adaptor: adaptor,
      resource: resource
    )

    expect(result).to be_success

    delete_result_for(
      adaptor: adaptor,
      raise_if_error: true,
      resource: result.resource
    )
  end
end

RSpec.shared_examples 'a netsuite delete' do
  it do
    result = create_result_for(
      adaptor: adaptor,
      raise_if_error: true,
      resource: resource
    )

    resource = result.resource

    result = delete_result_for(
      adaptor: adaptor,
      resource: resource
    )

    expect(result).to be_success
  ensure

    result = delete_result_for(
      adaptor: adaptor,
      resource: resource
    )

    expect(result).to be_failure
  end
end

RSpec.shared_examples 'a netsuite find' do
  it do
    result = create_result_for(
      adaptor: adaptor,
      raise_if_error: true,
      resource: resource
    )
    expect(result).to be_success
    resource = result.resource

    begin
      result = find_result_for(
        adaptor: adaptor,
        resource: resource
      )

      expect(result).to be_success
      ensure
        # Be sure to delete resource or raise an exception if this fails
        delete_result_for(
          adaptor: adaptor,
          raise_if_error: true,
          resource: resource
        )
    end
  end
end

RSpec.shared_examples 'a netsuite update' do
  it do
    result = create_result_for(
      adaptor: adaptor,
      raise_if_error: true,
      resource: resource
    )

    expect(result).to be_success
    resource = result.resource

    begin
      # Ensure values are currently not the same as the updates
      attribute_updates.each do |k, v|
        expect(resource.send(k)).not_to eq(v)
      end

      resource.assign_attributes(attribute_updates)
      result = update_result_for(
        adaptor: adaptor,
        resource: resource
      )

      expect(result).to be_success
      resource = result.resource

      # Ensure values are updated
      attribute_updates.each do |k, v|
        expect(resource.send(k)).to eq(v)
      end

      result = find_result_for(
        adaptor: adaptor,
        raise_if_error: true,
        resource: resource.class.new(
          ledger_id: resource.ledger_id
        )
      )

      expect(result).to be_success
      resource = result.resource

      # Ensure values are updated after raw find
      attribute_updates.each do |k, v|
        expect(resource.send(k)).to eq(v)
      end
    ensure
      delete_result_for(
        adaptor: adaptor,
        raise_if_error: true,
        resource: resource
      )
    end
  end
end

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
  it_behaves_like 'a netsuite create'
  it_behaves_like 'a netsuite delete'
  it_behaves_like 'a netsuite find'
  it_behaves_like 'a netsuite update'
  it_behaves_like 'a record with metadata'
end
