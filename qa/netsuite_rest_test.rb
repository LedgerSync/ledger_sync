# frozen_string_literal: true

module QA
  class NetSuiteRESTTest < QA::Test
    def run
      puts 'Testing NetSuite REST API'

      result = LedgerSync::Adaptors::NetSuiteREST::Customer::Operations::Create.new(
        resource: customer_resource
      )

    end

    def adaptor
      @adaptor ||= LedgerSync.adaptors.netsuite_rest.new(
        account_id: config['netsuite_rest']['account_id'],
        consumer_key: config['netsuite_rest']['consumer_key'],
        consumer_secret: config['netsuite_rest']['consumer_secret'],
        token_id: config['netsuite_rest']['token_id'],
        token_secret: config['netsuite_rest']['token_secret']
      )
    end
  end
end
