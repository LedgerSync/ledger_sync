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

    def cleanup; end

    def run
      puts 'Testing NetSuite REST API'

      # test_request = adaptor.get(path: '/metadata-catalog/record?select=customer')

      customer = new_customer
      customer.subsidiary = LedgerSync::Subsidiary.new(ledger_id: 2, name: "QA Customer #{test_run_id}")

      result = perform(
        LedgerSync::Adaptors::NetSuiteREST::Customer::Operations::Create.new(
          adaptor: adaptor,
          resource: customer
        )
      )

      customer = result.resource

      result = perform(
        LedgerSync::Adaptors::NetSuiteREST::Customer::Operations::Find.new(
          adaptor: adaptor,
          resource: customer
        )
      )

      customer = result.resource
      customer.name = "QA UPDATE #{test_run_id}"

      result = perform(
        LedgerSync::Adaptors::NetSuiteREST::Customer::Operations::Update.new(
          adaptor: adaptor,
          resource: customer
        )
      )

      customer = result.resource

      perform(
        LedgerSync::Adaptors::NetSuiteREST::Customer::Operations::Delete.new(
          adaptor: adaptor,
          resource: customer
        )
      )

      result = LedgerSync::Adaptors::NetSuiteREST::Customer::Operations::Delete.new(
        adaptor: adaptor,
        resource: customer
      ).perform

      unless result.failure?
        pdb 'Should be failure'
        byebug
      end

      pdb 'Done'
    end
  end
end
