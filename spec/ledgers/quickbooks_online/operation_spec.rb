# frozen_string_literal: true

require 'spec_helper'

support :quickbooks_online_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Operation do
  include QuickBooksOnlineHelpers

  describe '#perform' do
    it do
      customer1 = LedgerSync::Customer.new(
        name: 'Customer 1'
      )

      customer2 = LedgerSync::Customer.new(
        name: 'Customer 2'
      )

      operation1 = LedgerSync::Ledgers::QuickBooksOnline::Customer::Operations::Create.new(
        connection: quickbooks_online_connection,
        resource: customer1
      )

      operation2 = LedgerSync::Ledgers::QuickBooksOnline::Customer::Operations::Create.new(
        connection: quickbooks_online_connection,
        resource: customer2
      )

      stub_customer_create(
        request_body: customer_request_body_hash.merge(
          'DisplayName' => 'Customer 1',
          'PrimaryEmailAddr' => {
            'Address' => nil
          }
        )
      )
      result1 = operation1.perform
      expect(result1.response.request.body.fetch('DisplayName')).to eq('Customer 1')

      stub_customer_create(
        request_body: customer_request_body_hash.merge(
          'DisplayName' => 'Customer 2',
          'PrimaryEmailAddr' => {
            'Address' => nil
          }
        )
      )
      result2 = operation2.perform
      expect(result2.response.request.body.fetch('DisplayName')).to eq('Customer 2')
    end
  end
end
