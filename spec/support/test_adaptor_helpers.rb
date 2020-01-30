# frozen_string_literal: true

module TestAdaptorHelpers
  def test_customer(*args)
    LedgerSync::Customer.new(*args)
  end

  def test_customer_create_operation
    LedgerSync::Adaptors::NetSuite::Customer::Operations::Create.new(
      adaptor: netsuite_adaptor,
      resource: test_customer
    )
  end

  def test_customer_update_operation
    LedgerSync::Adaptors::NetSuite::Customer::Operations::Update.new(
      adaptor: netsuite_adaptor,
      resource: test_customer
    )
  end

  def test_searcher
    LedgerSync::Adaptors::NetSuite::Customer::Searcher.new(
      adaptor: netsuite_adaptor,
      query: ''
    )
  end

  def netsuite_adaptor
    LedgerSync.adaptors.test.new
  end
end
