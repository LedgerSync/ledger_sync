# frozen_string_literal: true

module QA
  class NetSuiteSOAPTest < QA::Test
    def cleanup
      netsuite_adaptor.setup
      delete_after.reverse.each(&:delete)
      netsuite_adaptor.teardown
    end

    def delete_after
      @delete_after ||= []
    end

    def run
      puts 'Testing NetSuite'

      result = create_subsidiary
               .and_then { |subsidiary| find_subsidiary(subsidiary: subsidiary) }
               .and_then { |subsidiary| create_customer(subsidiary: subsidiary) }
               .and_then { |customer| find_customer(customer: customer) }

      pdb result.success?
    ensure
      cleanup
      puts 'Completed NetSuite Tests'
    end

    def create_customer(subsidiary:)
      result = perform(
        LedgerSync::Adaptors::NetSuite::Customer::Operations::Create.new(
          adaptor: netsuite_adaptor,
          resource: new_customer(
            subsidiary: subsidiary
          )
        )
      )

      return result if result.failure?

      delete_after << result.response
      Resonad.Success(result.resource)
    end

    def create_subsidiary
      result = perform(
        LedgerSync::Adaptors::NetSuite::Subsidiary::Operations::Create.new(
          adaptor: netsuite_adaptor,
          resource: LedgerSync::Subsidiary.new(
            external_id: "ext_#{test_run_id}",
            name: "Subsidiary - #{test_run_id}",
            state: 'CA'
          )
        )
      )

      return result if result.failure?

      delete_after << result.response

      Resonad.Success(result.resource)
    end

    def find_customer(customer:)
      result = perform(
        LedgerSync::Adaptors::NetSuite::Customer::Operations::Find.new(
          adaptor: netsuite_adaptor,
          resource: customer
        )
      )

      return result if result.failure?

      Resonad.Success(result.resource)
    end

    def find_subsidiary(subsidiary:)
      result = perform(
        LedgerSync::Adaptors::NetSuite::Subsidiary::Operations::Find.new(
          adaptor: netsuite_adaptor,
          resource: subsidiary
        )
      )

      return result if result.failure?

      Resonad.Success(result.resource)
    end

    def netsuite_adaptor
      @netsuite_adaptor ||= LedgerSync::Adaptors::NetSuite::Adaptor.new(
        account_id: config['netsuite']['account_id'],
        api_version: config['netsuite']['api_version'],
        consumer_key: config['netsuite']['consumer_key'],
        consumer_secret: config['netsuite']['consumer_secret'],
        token_id: config['netsuite']['token_id'],
        token_secret: config['netsuite']['token_secret']
      )
    end
  end
end
