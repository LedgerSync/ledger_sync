module InputHelpers
  def customer(**merge)
    {
      object: :customer,
      resource_external_id: 'cus_1',
      resource_type: 'customer',
      data: {
        email: 'test@example.com',
        name: 'Sample Customer'
      }
    }.merge(merge)
  end

  def customer_resources(**merge)
    {
      customer: {
        c1: customer(merge)
      }
    }
  end

  def vendor(**merge)
    {
      object: :vendor,
      resource_external_id: 'ven_1',
      resource_type: 'vendor',
      data: {
        email: 'test@example.com',
        first_name: 'Sample',
        last_name: 'Vendor'
      }
    }.merge(merge)
  end

  def vendor_resources(**merge)
    {
      vendor: {
        v1: vendor(merge)
      }
    }
  end

  def account(**merge)
    {
      object: :account,
      resource_external_id: 'ven_1',
      resource_type: 'account',
      data: {
        name: 'Sample Account',
        account_type: 'bank',
        account_sub_type: 'cash_on_hand',
        currency: 'USD',
        description: 'This is Sample Account',
        active: true
      }
    }.merge(merge)
  end

  def account_resources(**merge)
    {
      account: {
        a1: account(merge)
      }
    }
  end

  def payment(**merge)
    {
      object: :payment,
      resource_external_id: 'pay_1',
      resource_type: 'payment',
      data: {
        amount: 12_345,
        currency: :usd,
        customer: :c1
      }
    }.merge(merge)
  end

  def payment_resources(**merge)
    {
      customer: {
        c1: customer(merge),
      },
      payment: {
        p1: payment(merge)
      }
    }
  end

  def expense(**merge)
    {
      object: :expense,
      resource_external_id: 'exp_1',
      resource_type: 'expense',
      data: {
        amount: 12_345,
        currency: :usd,
        account: :a1,
        vendor: :v1,
        memo: 'Memo',
        payment_type: 'cash',
        exchange_rate: 1.0,
        transaction_date: Date.parse('2019-09-01'),
        line_items: [:li1, :li2]
      }
    }.merge(merge)
  end

  def expense_resources(**merge)
    {
      vendor: {
        v1: vendor({resource_external_id: 'v_1'}.merge(merge))
      },
      account: {
        a1: account({resource_external_id: 'a_1'}.merge(merge))
      },
      expense: {
        e1: expense(merge)
      },
      expense_line_item: {
        li1: expense_line_item({resource_external_id: 'li_1'}),
        li2: expense_line_item({resource_external_id: 'li_2'})
      }
    }
  end

  def expense_line_item(**merge)
    {
      object: :expense_line_item,
      resource_external_id: 'li_1',
      resource_type: 'expense_line_item',
      data: {
        account: :a1,
        amount: 12_345,
        description: 'Sample Transaction'
      }
    }.merge(merge)
  end

  def quickbooks_config
    {
      api_token: 'this_is_a_token'
    }
  end
end
