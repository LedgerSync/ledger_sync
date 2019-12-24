# frozen_string_literal: true

support :netsuite_adaptor_helpers,
        :netsuite_shared_examples

module NetSuiteHelpers
  def create_operation_for(resource:)
    operation_for(
      method: :create,
      resource: resource
    )
  end

  def create_result_for(adaptor:, raise_if_error: false, resource:)
    result_for(
      adaptor: adaptor,
      method: :create,
      raise_if_error: raise_if_error,
      resource: resource
    )
  end

  def delete_operation_for(resource:)
    operation_for(
      method: :delete,
      resource: resource
    )
  end

  def delete_result_for(adaptor:, raise_if_error: false, resource:)
    result_for(
      adaptor: adaptor,
      method: :delete,
      raise_if_error: raise_if_error,
      resource: resource
    )
  end

  def existing_subsidiary_resource
    LedgerSync::Subsidiary.new(
      ledger_id: 2,
      name: "QA Subsidary #{test_run_id}"
    )
  end

  def find_operation_for(resource:)
    operation_for(
      method: :find,
      resource: resource
    )
  end

  def find_result_for(adaptor:, raise_if_error: false, resource:)
    result_for(
      adaptor: adaptor,
      method: :find,
      raise_if_error: raise_if_error,
      resource: resource
    )
  end

  def operation_for(method:, resource:)
    LedgerSync::Adaptors::NetSuite::Adaptor
      .base_operation_module_for(resource_class: resource.class)
      .const_get(LedgerSync::Util::StringHelpers.camelcase(method.to_s))
  end

  def result_for(adaptor:, method:, raise_if_error: false, resource:)
    result = operation_for(
      method: method,
      resource: resource
    ).new(
      adaptor: adaptor,
      resource: resource
    ).perform

    result = result.raise_if_error if raise_if_error
    result
  end

  def update_operation_for(resource:)
    operation_for(
      method: :update,
      resource: resource
    )
  end

  def update_result_for(adaptor:, raise_if_error: false, resource:)
    result_for(
      adaptor: adaptor,
      method: :update,
      raise_if_error: raise_if_error,
      resource: resource
    )
  end

  def self.included(base)
    base.include(NetSuiteAdaptorHelpers)
  end
end

RSpec.configure do |config|
  config.include NetSuiteHelpers, adaptor: :netsuite
end
