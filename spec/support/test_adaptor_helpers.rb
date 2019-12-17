module TestAdaptorHelpers
  def test_customer(*args)
    LedgerSync::Customer.new(*args)
  end

  def test_customer_create_operation
    LedgerSync::Adaptors::Test::Customer::Operations::Create.new(
      adaptor: test_adaptor,
      resource: test_customer
    )
  end

  def test_customer_update_operation
    LedgerSync::Adaptors::Test::Customer::Operations::Update.new(
      adaptor: test_adaptor,
      resource: test_customer
    )
  end

  def test_searcher
    LedgerSync::Adaptors::Test::Customer::Searcher.new(
      adaptor: test_adaptor,
      query: ''
    )
  end

  def test_adaptor
    LedgerSync.adaptors.test.new
  end
end
