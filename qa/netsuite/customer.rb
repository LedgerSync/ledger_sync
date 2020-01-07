# frozen_string_literal: true

module QA
  module NetSuite
    module Customer
      def customer_create
        perform(
          LedgerSync::Adaptors::NetSuite::Customer::Operations::Create.new(
            adaptor: adaptor,
            resource: new_customer(
              subsidiary: existing_netsuite_subsidiary
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
        schema = adaptor.base_module::Record::Metadata.new(
          adaptor: adaptor,
          record: :customer
        )

        # byebug unless schema['items'].count == 1

        LedgerSync::Result.Success(schema)
      end
    end
  end
end
