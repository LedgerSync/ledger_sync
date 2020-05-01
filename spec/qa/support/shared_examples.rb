# frozen_string_literal: true

RSpec.shared_examples 'a create' do |delete: true|
  it do
    result = create_result_for(
      adaptor: adaptor,
      resource: resource
    )

    byebug if result.failure?

    expect(result).to be_success

    if delete
      delete_result_for(
        adaptor: adaptor,
        resource: result.resource
      ).raise_if_error
    end
  end
end

RSpec.shared_examples 'a delete' do
  it do
    result = create_result_for(
      adaptor: adaptor,
      resource: resource
    ).raise_if_error

    resource = result.resource

    result = delete_result_for(
      adaptor: adaptor,
      resource: resource
    )

    expect(result).to be_success

    result = delete_result_for(
      adaptor: adaptor,
      resource: resource
    )

    expect(result).to be_failure
  end
end

RSpec.shared_examples 'a find' do |delete: true|
  it do
    result = create_result_for(
      adaptor: adaptor,
      resource: resource
    )

    byebug if result.failure?
    result.raise_if_error
    expect(result).to be_success
    resource = result.resource

    begin
      result = find_result_for(
        adaptor: adaptor,
        resource: resource
      )

      expect(result).to be_success
    ensure
      if delete
        # Be sure to delete resource or raise an exception if this fails
        delete_result_for(
          adaptor: adaptor,
          resource: resource
        ).raise_if_error
      end
    end
  end
end

RSpec.shared_examples 'a find only' do
  it do
    result = find_result_for(
      adaptor: adaptor,
      resource: resource
    )

    expect(result).to be_success
  end
end

RSpec.shared_examples 'an update' do |delete: true|
  it do
    result = create_result_for(
      adaptor: adaptor,
      resource: resource
    ).raise_if_error

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
        resource: resource.class.new(
          ledger_id: resource.ledger_id
        )
      ).raise_if_error

      expect(result).to be_success
      resource = result.resource

      # Ensure values are updated after raw find
      attribute_updates.each do |k, v|
        expect(resource.send(k)).to eq(v)
      end
    ensure
      if delete
        delete_result_for(
          adaptor: adaptor,
          resource: resource
        ).raise_if_error
      end
    end
  end
end

RSpec.shared_examples 'a searcher' do
  it do
    result = adaptor.searcher_for?(resource_type: resource.class.resource_module_str).search

    byebug if result.failure?

    expect(result).to be_success
  end
end

