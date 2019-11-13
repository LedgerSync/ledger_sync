# frozen_string_literal: true

module QA
  class QuickBooksOnlineTest < QA::Test
    def adaptor
      @adaptor ||= LedgerSync.adaptors.stripe.new(
        api_key: config['stripe']['api_key']
      )
    end

    def run
      puts 'Testing Stripe'

      result = perform(
        LedgerSync::Adaptors::Stripe::Customer::Operations::Create.new(
          adaptor: adaptor,
          resource: new_customer
        )
      )

      pdb result.success?
      config
    end
  end
end
