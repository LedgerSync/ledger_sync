# frozen_string_literal: true

module Test
  module QuickBooksOnline
    class Preferences
      def self.stub
        {
          ledger_id: nil,
          ledger_class: name.demodulize,
          ledger_resource: 'Preferences',
          request_hash: {},
          response_hash: {
            'AccountingInfoPrefs' => {
              'TrackDepartments' => true,
              'DepartmentTerminology' => 'Department',
              'ClassTrackingPerTxn' => false,
              'ClassTrackingPerTxnLine' => true,
              'CustomerTerminology' => 'Customers'
            },
            'ProductAndServicesPrefs' => {
              'ForSales' => true,
              'ForPurchase' => true,
              'QuantityWithPriceAndRate' => true,
              'QuantityOnHand' => true
            },
            'SalesFormsPrefs' => {
              'CustomField' => [
                {
                  'CustomField' => [
                    { 'Name' => 'SalesFormsPrefs.UseSalesCustom3', 'Type' => 'BooleanType', 'BooleanValue' => false },
                    { 'Name' => 'SalesFormsPrefs.UseSalesCustom1', 'Type' => 'BooleanType', 'BooleanValue' => true },
                    { 'Name' => 'SalesFormsPrefs.UseSalesCustom2', 'Type' => 'BooleanType', 'BooleanValue' => false }
                  ]
                }
              ],
              'CustomTxnNumbers' => false,
              'AllowDeposit' => false,
              'AllowDiscount' => false,
              'AllowEstimates' => true,
              'ETransactionEnabledStatus' => 'NotApplicable',
              'ETransactionAttachPDF' => false,
              'ETransactionPaymentEnabled' => false,
              'IPNSupportEnabled' => false,
              'AllowServiceDate' => false,
              'AllowShipping' => false,
              'UsingPriceLevels' => false,
              'DefaultCustomerMessage' => 'Thank you for your business and have a great day!'
            },
            'EmailMessagesPrefs' => {
              'InvoiceMessage' => {
                'Subject' => "Invoice from Craig's Design and Landscaping Services",
                'Message' => "Your invoice is attached.  Please remit payment at your earliest convenience.\nThank"\
                             "you for your business - we appreciate it very much.\n\nSincerely,\nCraig's Design and "\
                             'Landscaping Services'
              },
              'EstimateMessage' => {
                'Subject' => "Estimate from Craig's Design and Landscaping Services",
                'Message' => "Please review the estimate below.  Feel free to contact us if you have any questions.\n"\
                "We look forward to working with you.\n\nSincerely,\nCraig's Design and Landscaping Services"
              },
              'SalesReceiptMessage' => {
                'Subject' => "Sales Receipt from Craig's Design and Landscaping Services",
                'Message' => "Your sales receipt is attached.\nThank you for your business - we appreciate it very"\
                "mutch.\n\nSincerely,\nCraig's Design and Landscaping Services"
              },
              'StatementMessage' => {
                'Subject' => "Statement from Craig's Design and Landscaping Services",
                'Message' => "Your statement is attached.  Please remit payment at your earliest convenience.\nThank "\
                "you for your business - we appreciate it very much.\n\nSincerely,\nCraig's Design and Landscaping"\
                'Services'
              }
            },
            'VendorAndPurchasesPrefs' => {
              'TrackingByCustomer' => true,
              'BillableExpenseTracking' => false,
              'POCustomField' => [
                {
                  'CustomField' => [
                    { 'Name' => 'PurchasePrefs.UsePurchaseCustom1', 'Type' => 'BooleanType', 'BooleanValue' => true },
                    { 'Name' => 'PurchasePrefs.UsePurchaseCustom2', 'Type' => 'BooleanType', 'BooleanValue' => true },
                    { 'Name' => 'PurchasePrefs.UsePurchaseCustom3', 'Type' => 'BooleanType', 'BooleanValue' => false }
                  ]
                }, {
                  'CustomField' => [
                    {
                      'Name' => 'PurchasePrefs.PurchaseCustomName1',
                      'Type' => 'StringType',
                      'StringValue' => 'Crew #'
                    },
                    {
                      'Name' => 'PurchasePrefs.PurchaseCustomName2',
                      'Type' => 'StringType',
                      'StringValue' => 'Sales Rep'
                    }
                  ]
                }
              ]
            },
            'TimeTrackingPrefs' => {
              'UseServices' => true,
              'BillCustomers' => true,
              'ShowBillRateToAll' => false,
              'WorkWeekStartDate' => 'Monday',
              'MarkTimeEntriesBillable' => true
            },
            'TaxPrefs' => { 'UsingSalesTax' => false },
            'CurrencyPrefs' => {
              'MultiCurrencyEnabled' => false,
              'HomeCurrency' => { 'value' => 'USD' }
            },
            'ReportPrefs' => {
              'ReportBasis' => 'Accrual',
              'CalcAgingReportFromTxnDate' => false
            },
            'OtherPrefs' => {
              'NameValue' => [
                {
                  'Name' => 'SalesFormsPrefs.DefaultCustomerMessage',
                  'Value' => 'Thank you for your business and have a great day!'
                },
                { 'Name' => 'SalesFormsPrefs.DefaultItem', 'Value' => '33' },
                { 'Name' => 'DTXCopyMemo', 'Value' => 'true' },
                { 'Name' => 'UncategorizedAssetAccountId', 'Value' => '346' },
                { 'Name' => 'UncategorizedIncomeAccountId', 'Value' => '347' },
                { 'Name' => 'UncategorizedExpenseAccountId', 'Value' => '349' },
                { 'Name' => 'MasAccountId', 'Value' => '384' },
                { 'Name' => 'SFCEnabled', 'Value' => 'true' },
                { 'Name' => 'DataPartner', 'Value' => 'false' },
                { 'Name' => 'Vendor1099Enabled', 'Value' => 'true' },
                { 'Name' => 'TimeTrackingFeatureEnabled', 'Value' => 'true' },
                { 'Name' => 'FDPEnabled', 'Value' => 'false' },
                { 'Name' => 'isDTXOnStage', 'Value' => 'false' },
                { 'Name' => 'ProjectsEnabled', 'Value' => 'false' }
              ]
            },
            'domain' => 'QBO',
            'sparse' => false,
            'Id' => '1',
            'SyncToken' => '4',
            'MetaData' => {
              'CreateTime' => '2019-03-27T01:02:48-07:00',
              'LastUpdatedTime' => '2020-01-24T05:24:45-08:00'
            },
            'time' => '2020-01-24T08:52:31.870-08:00'
          }
        }
      end
    end
  end
end
