# frozen_string_literal: true

require_relative 'netsuite/customer'
require_relative 'netsuite/vendor'
module QA
  class NetSuiteTest < QA::Test
    include NetSuite::Customer
    include NetSuite::Vendor

    def adaptor
      @adaptor ||= LedgerSync.adaptors.netsuite.new(
        account_id: config['netsuite']['account_id'],
        consumer_key: config['netsuite']['consumer_key'],
        consumer_secret: config['netsuite']['consumer_secret'],
        token_id: config['netsuite']['token_id'],
        token_secret: config['netsuite']['token_secret']
      )
    end

    def run
      puts 'Testing NetSuite REST API'

      schema_customer
        .and_then { customer_create }
        .and_then { |result| customer_find(customer: result.resource) }
        .and_then { |result| customer_update(customer: result.resource) }
        .and_then { |result| customer_delete(customer: result.resource) }
        .and_then { |result| customer_delete_nonexisting(customer: result.resource) }
        .and_then { schema_vendor }
        .and_then { vendor_create }
        .and_then { vendor_create }
        .and_then { |result| vendor_find(vendor: result.resource) }
        .and_then { |result| vendor_update(vendor: result.resource) }
        .and_then { |result| vendor_delete(vendor: result.resource) }
        .and_then { |result| vendor_delete_nonexisting(vendor: result.resource) }

      schema_customer

      pdb 'Done'
    end
  end
end
