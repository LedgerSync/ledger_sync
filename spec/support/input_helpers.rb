# frozen_string_literal: true

module InputHelpers # rubocop:disable Metrics/ModuleLength
  def customer_resource(**merge)
    {
      external_id: :ext_id,
      ledger_id: nil,
      # attributes
      email: 'test@example.com',
      name: 'Sample Customer',
      subsidiary: local_resource_class(:subsidiary).new(subsidiary_resource)
    }.merge(merge)
  end

  def vendor_resource(**merge)
    {
      external_id: :ext_id,
      ledger_id: nil,
      # attributes
      email: 'test@example.com',
      display_name: 'Sample Vendor',
      first_name: 'Sample',
      last_name: 'Vendor'
    }.merge(merge)
  end

  def local_resource_class(type)
    described_class.inferred_client_class.resources[type]
  end

  def payment_resource(**merge)
    {
      external_id: :ext_id,
      ledger_id: nil,
      # relationships
      customer: nil,
      deposit_account: nil,
      account: nil,
      line_items: [],
      # attributes
      amount: 12_345,
      currency: local_resource_class(:currency).new(
        Name: 'United States Dollar',
        Symbol: 'USD'
      ),
      reference_number: 'Ref123',
      memo: 'Memo',
      exchange_rate: 1.0,
      transaction_date: Date.parse('2019-09-01')
    }.merge(merge)
  end

  def payment_line_item_resource(**merge)
    {
      amount: 0,
      ledger_transactions: []
    }.merge(merge)
  end

  def linked_txn_resource(**merge)
    {
      entity: nil
    }.merge(merge)
  end

  def invoice_resource(**merge)
    {
      external_id: :ext_id,
      ledger_id: nil,
      # relationships
      customer: nil,
      account: nil,
      line_items: [],
      # attributes
      currency: local_resource_class(:currency).new(
        Name: 'United States Dollar',
        Symbol: 'USD'
      ),
      memo: 'Memo 1',
      transaction_date: Date.parse('2019-09-01'),
      deposit: 100
    }.merge(merge)
  end

  def invoice_line_item_resource(**merge)
    {
      # relationships
      item: nil,
      # attributes
      amount: 0,
      description: 'Sample Description'
    }.merge(merge)
  end

  def expense_resource(**merge)
    {
      external_id: :ext_id,
      ledger_id: nil,
      # relationships
      account: nil,
      entity: nil,
      line_items: [],
      # attributes
      reference_number: 'Ref123',
      currency: local_resource_class(:currency).new(
        Name: 'United States Dollar',
        Symbol: 'USD'
      ),
      memo: 'Memo',
      payment_type: 'cash',
      exchange_rate: 1.0,
      transaction_date: Date.parse('2019-09-01')
    }.merge(merge)
  end

  def expense_line_item_resource(**merge)
    {
      external_id: :ext_id,
      ledger_id: nil,
      # relationships
      account: nil,
      # attributes
      amount: 12_345,
      description: 'Sample Transaction'
    }.merge(merge)
  end

  def transfer_resource(**merge)
    {
      external_id: :ext_id,
      ledger_id: nil,
      # relationships
      from_account: nil,
      to_account: nil,
      # attributes
      amount: 12_345,
      currency: local_resource_class(:currency).new(
        Name: 'United States Dollar',
        Symbol: 'USD'
      ),
      memo: 'Memo',
      transaction_date: Date.parse('2019-09-01')
    }.merge(merge)
  end

  def deposit_resource(**merge)
    {
      external_id: :ext_id,
      ledger_id: nil,
      # relationships
      account: nil,
      department: nil,
      line_items: [],
      # attributes
      currency: local_resource_class(:currency).new(
        Name: 'United States Dollar',
        Symbol: 'USD'
      ),
      memo: 'Memo',
      exchange_rate: 1.0,
      transaction_date: Date.parse('2019-09-01')
    }.merge(merge)
  end

  def deposit_line_item_resource(**merge)
    {
      external_id: :ext_id,
      ledger_id: nil,
      # relationships
      account: nil,
      # attributes
      amount: 12_345,
      description: 'Sample Transaction'
    }.merge(merge)
  end

  def bill_resource(**merge)
    {
      external_id: :ext_id,
      ledger_id: nil,
      # relationships
      account: nil,
      vendor: nil,
      line_items: [],
      # attributes
      reference_number: 'Ref123',
      currency: local_resource_class(:currency).new(
        Name: 'United States Dollar',
        Symbol: 'USD'
      ),
      memo: 'Memo',
      transaction_date: Date.parse('2019-09-01'),
      due_date: Date.parse('2019-09-01')
    }.merge(merge)
  end

  def bill_line_item_resource(**merge)
    {
      external_id: :ext_id,
      ledger_id: nil,
      # relationships
      account: nil,
      # attributes
      amount: 12_345,
      description: 'Sample Transaction'
    }.merge(merge)
  end

  def journal_entry_resource(**merge)
    {
      external_id: :ext_id,
      ledger_id: nil,
      # relationships
      line_items: [],
      # attributes
      reference_number: 'Ref123',
      currency: local_resource_class(:currency).new(
        Name: 'United States Dollar',
        Symbol: 'USD'
      ),
      memo: 'Memo',
      transaction_date: Date.parse('2019-09-01')
    }.merge(merge)
  end

  def journal_entry_line_item_resource(**merge)
    {
      external_id: :ext_id,
      ledger_id: nil,
      # relationships
      account: nil,
      # attributes
      amount: 12_345,
      description: 'Sample Transaction',
      entry_type: 'credit'
    }.merge(merge)
  end

  def quickbooks_config
    {
      api_token: 'this_is_a_token'
    }
  end

  def subsidiary_resource(**merge)
    {
      external_id: 'sub_123',
      name: 'Test subsidiary',
      state: 'CA'
    }.merge(merge)
  end

  def ledger_class_resource(**merge)
    {
      external_id: :ext_id,
      name: 'Test Class',
      active: true,
      sub_class: false
    }.merge(merge)
  end

  def department_resource(**merge)
    {
      external_id: :ext_id,
      name: 'Test Department',
      active: true,
      sub_department: false
    }.merge(merge)
  end
end
