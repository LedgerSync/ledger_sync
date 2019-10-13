module InputHelpers
  def customer_resource(**merge)
    {
      external_id: nil,
      ledger_id: nil,
      sync_token: nil,
      # attributes
      email: 'test@example.com',
      name: 'Sample Customer'
    }.merge(merge)
  end

  def vendor_resource(**merge)
    {
      external_id: nil,
      ledger_id: nil,
      sync_token: nil,
      # attributes
      email: 'test@example.com',
      display_name: 'Sample Vendor',
      first_name: 'Sample',
      last_name: 'Vendor'
    }.merge(merge)
  end

  def account_resource(**merge)
    {
      external_id: nil,
      ledger_id: nil,
      sync_token: nil,
      # attributes
      name: 'Sample Account',
      account_type: 'bank',
      account_sub_type: 'cash_on_hand',
      currency: 'USD',
      description: 'This is Sample Account',
      active: true
    }.merge(merge)
  end

  def payment_resource(**merge)
    {
      external_id: nil,
      ledger_id: nil,
      sync_token: nil,
      # relationships
      customer: nil,
      # attributes
      amount: 12_345,
      currency: 'USD'
    }.merge(merge)
  end

  def expense_resource(**merge)
    {
      external_id: nil,
      ledger_id: nil,
      sync_token: nil,
      # relationships
      account: nil,
      vendor: nil,
      line_items: [],
      #attributes
      amount: 12_345,
      currency: 'USD',
      memo: 'Memo',
      payment_type: 'cash',
      exchange_rate: 1.0,
      transaction_date: Date.parse('2019-09-01')
    }.merge(merge)
  end

  def expense_line_item_resource(**merge)
    {
      external_id: nil,
      ledger_id: nil,
      sync_token: nil,
      # relationships
      account: nil,
      # attributes
      amount: 12_345,
      description: 'Sample Transaction'
    }.merge(merge)
  end

  def transfer_resource(**merge)
    {
      external_id: nil,
      ledger_id: nil,
      sync_token: nil,
      # relationships
      from_account: nil,
      to_account: nil,
      #attributes
      amount: 12_345,
      currency: 'USD',
      memo: 'Memo',
      transaction_date: Date.parse('2019-09-01')
    }.merge(merge)
  end

  def deposit_resource(**merge)
    {
      external_id: nil,
      ledger_id: nil,
      sync_token: nil,
      # relationships
      account: nil,
      line_items: [],
      #attributes
      currency: 'USD',
      memo: 'Memo',
      exchange_rate: 1.0,
      transaction_date: Date.parse('2019-09-01')
    }.merge(merge)
  end

  def deposit_line_item_resource(**merge)
    {
      external_id: nil,
      ledger_id: nil,
      sync_token: nil,
      # relationships
      account: nil,
      # attributes
      amount: 12_345,
      description: 'Sample Transaction'
    }.merge(merge)
  end

  def bill_resource(**merge)
    {
      external_id: nil,
      ledger_id: nil,
      sync_token: nil,
      # relationships
      account: nil,
      vendor: nil,
      line_items: [],
      #attributes
      currency: 'USD',
      memo: 'Memo',
      transaction_date: Date.parse('2019-09-01'),
      due_date: Date.parse('2019-09-01')
    }.merge(merge)
  end

  def bill_line_item_resource(**merge)
    {
      external_id: nil,
      ledger_id: nil,
      sync_token: nil,
      # relationships
      account: nil,
      # attributes
      amount: 12_345,
      description: 'Sample Transaction'
    }.merge(merge)
  end

  def journal_entry_resource(**merge)
    {
      external_id: nil,
      ledger_id: nil,
      sync_token: nil,
      # relationships
      line_items: [],
      #attributes
      currency: 'USD',
      memo: 'Memo',
      transaction_date: Date.parse('2019-09-01')
    }.merge(merge)
  end

  def journal_entry_line_item_resource(**merge)
    {
      external_id: nil,
      ledger_id: nil,
      sync_token: nil,
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
end
