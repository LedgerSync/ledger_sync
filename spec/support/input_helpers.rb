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

  def quickbooks_config
    {
      api_token: 'this_is_a_token'
    }
  end
end
