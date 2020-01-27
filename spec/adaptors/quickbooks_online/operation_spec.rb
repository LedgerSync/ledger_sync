# frozen_string_literal: true

require 'spec_helper'

support :quickbooks_online_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::Operation do
  include QuickBooksOnlineHelpers

  describe '#perform' do
    it do
      customer1 = LedgerSync::Customer.new(
        name: 'Customer 1'
      )

      customer2 = LedgerSync::Customer.new(
        name: 'Customer 2'
      )

      operation1 = LedgerSync::Adaptors::QuickBooksOnline::Customer::Operations::Create.new(
        adaptor: quickbooks_online_adaptor,
        resource: customer1
      )

      operation2 = LedgerSync::Adaptors::QuickBooksOnline::Customer::Operations::Create.new(
        adaptor: quickbooks_online_adaptor,
        resource: customer2
      )

      stub_create_customer(
        request_overrides: {
          'DisplayName' => 'Customer 1',
          'PrimaryEmailAddr' => {
            'Address' => nil
          }
        }
      )
      result1 = operation1.perform
      expect(result1.response.request.body.fetch('DisplayName')).to eq('Customer 1')

      stub_create_customer(
        request_overrides: {
          'DisplayName' => 'Customer 2',
          'PrimaryEmailAddr' => {
            'Address' => nil
          }
        }
      )
      result2 = operation2.perform
      expect(result2.response.request.body.fetch('DisplayName')).to eq('Customer 2')
    end
  end
end
