# frozen_string_literal: true

module QA
  class NetSuiteRESTTest < QA::Test
    def adaptor
      @adaptor ||= LedgerSync.adaptors.netsuite_rest.new(
        account_id: config['netsuite_rest']['account_id'],
        consumer_key: config['netsuite_rest']['consumer_key'],
        consumer_secret: config['netsuite_rest']['consumer_secret'],
        token_id: config['netsuite_rest']['token_id'],
        token_secret: config['netsuite_rest']['token_secret']
      )
    end

    def run
      puts 'Testing NetSuite REST API'

      # test_request = adaptor.get(path: '/metadata-catalog/record?select=customer')

      # pdb test_request

      LedgerSync::Adaptors::NetSuiteREST::Customer::Operations::Find.new(
        adaptor: adaptor,
        resource: LedgerSync::Customer.new(ledger_id: 1137)
      ).perform

      result = LedgerSync::Adaptors::NetSuiteREST::Customer::Operations::Create.new(
        adaptor: adaptor,
        resource: new_customer
      ).perform

      byebug

      pdb 'Done'
    end
  end
end
