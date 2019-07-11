module AdaptorHelpers
  def adaptors
    @adaptors ||= LedgerSync.adaptors
  end

  def quickbooks_adaptor
    adaptors.quickbooks_online.new(
      access_token: 'access_token',
      client_id: 'client_id',
      client_secret: 'client_secret',
      realm_id: 'realm_id',
      refresh_token: 'refresh_token',
      test: true
    )
  end

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
    adaptors.test.new
  end
end
