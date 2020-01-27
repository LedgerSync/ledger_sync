# frozen_string_literal: true

require 'spec_helper'

support :ledger_serializer_helpers

RSpec.describe LedgerSync::Adaptors::QuickBooksOnline::LedgerSerializer do
  include LedgerSerializerHelpers

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
    LedgerSync::Bill.new(
      line_items: [
        LedgerSync::BillLineItem.new(
          ledger_id: 1
        ),
        LedgerSync::BillLineItem.new(
          description: 'Testing 3'
        )
      ]
    )
  end

  describe '#deserialize' do
    it 'merges using replace by default' do
      serializer_class = LedgerSync::Adaptors::QuickBooksOnline::Bill::LedgerSerializer
      serializer = serializer_class.new(resource: local_bill)
      merged_resource = serializer.deserialize(hash: bill_hash_from_quickbooks)

      serialized_line_items = [
        {
          'DetailType' => 'AccountBasedExpenseLineDetail',
          'Amount' => 103.55,
          'Id' => '1',
          'AccountBasedExpenseLineDetail' => {
            'AccountRef' => {
              'value' => '64'
            },
            'ClassRef' => {
              'value' => nil
            }
          },
          'Description' => 'Lumber 1'
        },
        {
          'DetailType' => 'AccountBasedExpenseLineDetail',
          'Amount' => 103.55,
          'Id' => '2',
          'AccountBasedExpenseLineDetail' => {
            'AccountRef' => {
              'value' => '64'
            },
            'ClassRef' => {
              'value' => nil
            }
          },
          'Description' => 'Lumber 2'
        }
      ]
      expect(serializer_class.new(resource: merged_resource).to_ledger_hash['Line']).to eq(serialized_line_items)
    end

    it 'merges to support quickbooks line items' do
      # merge_into needs for references_many needs to look for the
      # resource with that ID and merge the changes for the resource
      # into the returned hash.
      #
      # If many item does not exist on local resource, consider it a delete and ignore.
      #
      # If item on resource does not have ID or is not found in response, we consider it a create.

      serializer_class = LedgerSync::Adaptors::QuickBooksOnline::Bill::LedgerSerializer
      serializer = serializer_class.new(resource: local_bill)

      merged_resource = serializer.deserialize(
        hash: bill_hash_from_quickbooks,
        merge_for_full_update: true
      )

      serialized_line_items = [
        {
          'DetailType' => 'AccountBasedExpenseLineDetail',
          'Amount' => 103.55,
          'Id' => '1',
          'AccountBasedExpenseLineDetail' => {
            'AccountRef' => {
              'value' => '64'
            },
            'ClassRef' => {
              'value' => nil
            }
          },
          'Description' => 'Lumber 1'
        },
        {
          'DetailType' => 'AccountBasedExpenseLineDetail',
          'Amount' => nil,
          'Id' => nil,
          'AccountBasedExpenseLineDetail' => {
            'AccountRef' => {
              'value' => nil
            },
            'ClassRef' => {
              'value' => nil
            }
          },
          'Description' => 'Testing 3'
        }
      ]

      expect(serializer_class.new(resource: merged_resource).to_ledger_hash['Line']).to eq(serialized_line_items)
    end
  end

  describe '#to_ledger_hash' do
    it 'deep merges values' do
      serializer_class = LedgerSync::Adaptors::QuickBooksOnline::Customer::LedgerSerializer
      customer = LedgerSync::Customer.new(name: 'test', email: 'test@example.com')
      serializer = serializer_class.new(resource: customer)

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

      expect(serializer.to_ledger_hash(deep_merge_unmapped_values: previous_response)).to eq(h)
    end
  end
end
