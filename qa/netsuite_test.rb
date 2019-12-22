# frozen_string_literal: true

module QA
  class NetSuiteTest < QA::Test
    def adaptor
      @adaptor ||= LedgerSync.adaptors.netsuite.new(
        account_id: config['netsuite']['account_id'],
        consumer_key: config['netsuite']['consumer_key'],
        consumer_secret: config['netsuite']['consumer_secret'],
        token_id: config['netsuite']['token_id'],
        token_secret: config['netsuite']['token_secret']
      )
    end

    def customer_create
      perform(
        LedgerSync::Adaptors::NetSuite::Customer::Operations::Create.new(
          adaptor: adaptor,
          resource: new_customer(
            subsidiary: LedgerSync::Subsidiary.new(
              ledger_id: 2,
              name: "QA Customer #{test_run_id}"
            )
          )
        )
      )
    end

    def customer_delete(customer:)
      perform(
        LedgerSync::Adaptors::NetSuite::Customer::Operations::Delete.new(
          adaptor: adaptor,
          resource: customer
        )
      )
    end

    def customer_delete_nonexisting(customer:)
      result = LedgerSync::Adaptors::NetSuite::Customer::Operations::Delete.new(
        adaptor: adaptor,
        resource: customer
      ).perform

      unless result.failure?
        pdb 'Should be failure'
        byebug
      end

      LedgerSync::Result.Success
    end

    def customer_find(customer:)
      perform(
        LedgerSync::Adaptors::NetSuite::Customer::Operations::Find.new(
          adaptor: adaptor,
          resource: customer
        )
      )
    end

    def customer_update(customer:)
      name = "QA UPDATE #{test_run_id}"
      customer.name = name

      result = perform(
        LedgerSync::Adaptors::NetSuite::Customer::Operations::Update.new(
          adaptor: adaptor,
          resource: customer
        )
      )

      byebug if result.resource.name != name
      result
    end

    def schema_customer
      schema = adaptor.base_module::RecordMetadata.new(
        adaptor: adaptor,
        record: :customer
      ).to_h

      byebug unless schema['items'].count == 1

      LedgerSync::Result.Success(schema)
    end

    def run
      puts 'Testing NetSuite REST API'

      # customer_create
      #   .and_then { |result| customer_find(customer: result.resource) }
      #   .and_then { |result| customer_update(customer: result.resource) }
      #   .and_then { |result| customer_delete(customer: result.resource) }
      #   .and_then { |result| customer_delete_nonexisting(customer: result.resource) }

      schema_customer

      pdb 'Done'
    end
  end
end
