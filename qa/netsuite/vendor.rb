# frozen_string_literal: true

module QA
  module NetSuite
    module Vendor
      def vendor_create
        perform(
          LedgerSync::Adaptors::NetSuite::Vendor::Operations::Create.new(
            adaptor: adaptor,
            resource: new_vendor(
              subsidiary: existing_netsuite_subsidiary
            )
          )
        )
      end

      def vendor_delete(vendor:)
        perform(
          LedgerSync::Adaptors::NetSuite::Vendor::Operations::Delete.new(
            adaptor: adaptor,
            resource: vendor
          )
        )
      end

      def vendor_delete_nonexisting(vendor:)
        result = LedgerSync::Adaptors::NetSuite::Vendor::Operations::Delete.new(
          adaptor: adaptor,
          resource: vendor
        ).perform

        unless result.failure?
          pd 'Should be failure'
          byebug
        end

        LedgerSync::Result.Success
      end

      def vendor_find(vendor:)
        perform(
          LedgerSync::Adaptors::NetSuite::Vendor::Operations::Find.new(
            adaptor: adaptor,
            resource: vendor
          )
        )
      end

      def vendor_update(vendor:)
        name = "QA UPDATE #{test_run_id}"
        vendor.company_name = name

        result = perform(
          LedgerSync::Adaptors::NetSuite::Vendor::Operations::Update.new(
            adaptor: adaptor,
            resource: vendor
          )
        )

        byebug if result.resource.company_name != name
        result
      end

      def schema_vendor
        schema = adaptor.base_module::Record::Metadata.new(
          adaptor: adaptor,
          record: :vendor
        )

        # byebug unless schema['items'].count == 1

        LedgerSync::Result.Success(schema)
      end
    end
  end
end
