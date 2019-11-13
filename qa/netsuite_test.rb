# frozen_string_literal: true

module QA
  class NetSuiteTest < QA::Test
    def run
      puts 'Testing NetSuite'

      netsuite_adaptor = LedgerSync::Adaptors::NetSuite::Adaptor.new(
        account: config['netsuite']['account'],
        consumer_key: config['netsuite']['consumer_key'],
        consumer_secret: config['netsuite']['consumer_secret'],
        token_id: config['netsuite']['token_id'],
        token_secret: config['netsuite']['token_secret']
      )

      result = perform(LedgerSync::Adaptors::NetSuite::Customer::Operations::Create.new(
                         adaptor: netsuite_adaptor,
                         resource: new_customer
                       ))

      pdb result.success?
    end
  end
end
