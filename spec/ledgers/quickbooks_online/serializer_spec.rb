# frozen_string_literal: true

require 'spec_helper'

support :serialization_helpers

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Serializer do
  include SerializationHelpers

  let(:bill_hash_from_quickbooks) do
    {
      'SyncToken' => '2',
      'domain' => 'QBO',
      'APAccountRef' => {
        'name' => 'Accounts Payable (A/P)',
        'value' => '33'
      },
      'VendorRef' => {
        'name' => 'Norton Lumber and Building Materials',
        'value' => '46'
      },
      'TxnDate' => '2014-11-06',
      'TotalAmt' => 103.55,
      'CurrencyRef' => {
        'name' => 'United States Dollar',
        'value' => 'USD'
      },
      'LinkedTxn' => [
        {
          'TxnId' => '118',
          'TxnType' => 'BillPaymentCheck'
        }
      ],
      'SalesTermRef' => {
        'value' => '3'
      },
      'DueDate' => '2014-12-06',
      'sparse' => false,
      'Line' => [
        {
          'DetailType' => 'AccountBasedExpenseLineDetail',
          'Amount' => 103.55,
          'Id' => '1',
          'AccountBasedExpenseLineDetail' => {
            'TaxCodeRef' => {
              'value' => 'TAX'
            },
            'AccountRef' => {
              'name' => 'Job Expenses:Job Materials:Decks and Patios',
              'value' => '64'
            },
            'BillableStatus' => 'Billable',
            'CustomerRef' => {
              'name' => 'Travis Waldron',
              'value' => '26'
            }
          },
          'Description' => 'Lumber 1'
        },
        {
          'DetailType' => 'AccountBasedExpenseLineDetail',
          'Amount' => 103.55,
          'Id' => '2',
          'AccountBasedExpenseLineDetail' => {
            'TaxCodeRef' => {
              'value' => 'TAX'
            },
            'AccountRef' => {
              'name' => 'Job Expenses:Job Materials:Decks and Patios',
              'value' => '64'
            },
            'BillableStatus' => 'Billable',
            'CustomerRef' => {
              'name' => 'Travis Waldron',
              'value' => '26'
            }
          },
          'Description' => 'Lumber 2'
        }
      ],
      'Balance' => 0,
      'Id' => '25',
      'MetaData' => {
        'CreateTime' => '2014-11-06T15:37:25-08:00',
        'LastUpdatedTime' => '2015-02-09T10:11:11-08:00'
      }
    }
  end

  let(:local_bill) do
    LedgerSync::Ledgers::QuickBooksOnline::Bill.new(
      line_items: [
        LedgerSync::Ledgers::QuickBooksOnline::BillLineItem.new(
          ledger_id: 1
        ),
        LedgerSync::Ledgers::QuickBooksOnline::BillLineItem.new(
          description: 'Testing 3'
        )
      ]
    )
  end

  describe '#serialize' do
    it 'deep merges values' do
      serializer_class = LedgerSync::Ledgers::QuickBooksOnline::Customer::Serializer
      customer = LedgerSync::Ledgers::QuickBooksOnline::Customer.new(DisplayName: 'test', PrimaryEmailAddr: create(:quickbooks_online_primary_email_addr, Address: 'test@example.com'))
      serializer = serializer_class.new

      h = {
        'DisplayName' => 'test',
        'Id' => nil,
        'PrimaryPhone' => {
          'FreeFormNumber' => nil
        },
        'PrimaryEmailAddr' => {
          'Address' => 'test@example.com',
          'baz' => 123
        },
        'foo' => 'bar'
      }

      previous_response = {
        'foo' => 'bar',
        'PrimaryEmailAddr' => {
          'Address' => 'should not be in result',
          'baz' => 123
        }
      }

      expect(serializer.serialize(deep_merge_unmapped_values: previous_response, resource: customer)).to eq(h)
    end
  end
end
