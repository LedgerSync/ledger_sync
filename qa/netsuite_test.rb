# frozen_string_literal: true

module QA
  class NetSuiteTest < QA::Test
    def run
      puts 'Testing NetSuite'

      netsuite_adaptor = LedgerSync::Adaptors::NetSuite::Adaptor.new(
        account_id: config['netsuite']['account_id'],
        api_version: config['netsuite']['api_version'],
        consumer_key: config['netsuite']['consumer_key'],
        consumer_secret: config['netsuite']['consumer_secret'],
        token_id: config['netsuite']['token_id'],
        token_secret: config['netsuite']['token_secret']
      )

      # customer = NetSuite::Records::Customer.get(:internal_id => 309)

      result = perform(
        LedgerSync::Adaptors::NetSuite::Subsidiary::Operations::Create.new(
          adaptor: netsuite_adaptor,
          resource: LedgerSync::Subsidiary.new(
            external_id: "ext_#{TEST_RUN_ID}",
            name: "Subsidiary - #{TEST_RUN_ID}",
            state: 'CA'
          )
        )
      )

      result = perform(
        LedgerSync::Adaptors::NetSuite::Subsidiary::Operations::Find.new(
          adaptor: netsuite_adaptor,
          resource: result.resource
        )
      )

      result = perform(
        LedgerSync::Adaptors::NetSuite::Customer::Operations::Create.new(
          adaptor: netsuite_adaptor,
          resource: new_customer(
            subsidiary: result.resource
          )
        )
      )

      result = perform(
        LedgerSync::Adaptors::NetSuite::Customer::Operations::Find.new(
          adaptor: netsuite_adaptor,
          resource: result.resource
        )
      )

      pdb result.success?
    end
  end
end
