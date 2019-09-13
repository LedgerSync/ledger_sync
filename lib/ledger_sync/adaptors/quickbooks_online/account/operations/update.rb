# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Account
        module Operations
          class Update < Operation::Update
            class Contract < LedgerSync::Adaptors::Contract
              params do
                required(:ledger_id).filled(:string)
                required(:name).filled(:string)
                required(:account_type).filled(:string)
              end
            end

            ACCOUNT_TYPES = {
              # Bank
              'cash_on_hand' => 'CashOnHand',
              'checking' => 'Checking',
              'money_market' => 'MoneyMarket',
              'rents_held_in_trust' => 'RentsHeldInTrust',
              'savings' => 'Savings',
              'trust_accounts' => 'TrustAccounts',
              'cash_and_cash_equivalents' => 'CashAndCashEquivalents',
              'other_ear_marked_bank_accounts' => 'OtherEarMarkedBankAccounts',

              # # Other Current Asset
              # AllowanceForBadDebts
              # DevelopmentCosts
              # EmployeeCashAdvances
              # OtherCurrentAssets
              # Inventory
              # Investment_MortgageRealEstateLoans
              # Investment_Other
              # Investment_TaxExemptSecurities
              # Investment_USGovernmentObligations
              # LoansToOfficers
              # LoansToOthers
              # LoansToStockholders
              # PrepaidExpenses
              # Retainage
              # UndepositedFunds
              # AssetsAvailableForSale
              # BalWithGovtAuthorities
              # CalledUpShareCapitalNotPaid
              # ExpenditureAuthorisationsAndLettersOfCredit
              # GlobalTaxDeferred
              # GlobalTaxRefund
              # InternalTransfers
              # OtherConsumables
              # ProvisionsCurrentAssets
              # ShortTermInvestmentsInRelatedParties
              # ShortTermLoansAndAdvancesToRelatedParties
              # TradeAndOtherReceivables

              # # Fixed Asset
              # AccumulatedDepletion
              # AccumulatedDepreciation
              # DepletableAssets
              # FixedAssetComputers
              # FixedAssetCopiers
              # FixedAssetFurniture
              # FixedAssetPhone
              # FixedAssetPhotoVideo
              # FixedAssetSoftware
              # FixedAssetOtherToolsEquipment
              # FurnitureAndFixtures
              # Land
              # LeaseholdImprovements
              # OtherFixedAssets
              # AccumulatedAmortization
              # Buildings
              # IntangibleAssets
              # MachineryAndEquipment
              # Vehicles
              # AssetsInCourseOfConstruction
              # CapitalWip
              # CumulativeDepreciationOnIntangibleAssets
              # IntangibleAssetsUnderDevelopment
              # LandAsset
              # NonCurrentAssets
              # ParticipatingInterests
              # ProvisionsFixedAssets

              # # Other Asset
              # LeaseBuyout
              # OtherLongTermAssets
              # SecurityDeposits
              # AccumulatedAmortizationOfOtherAssets
              # Goodwill
              # Licenses
              # OrganizationalCosts
              # AssetsHeldForSale
              # AvailableForSaleFinancialAssets
              # DeferredTax
              # Investments
              # LongTermInvestments
              # LongTermLoansAndAdvancesToRelatedParties
              # OtherIntangibleAssets
              # OtherLongTermInvestments
              # OtherLongTermLoansAndAdvances
              # PrepaymentsAndAccruedIncome
              # ProvisionsNonCurrentAssets
            }

            private

            def operate
              ledger_resource_data = adaptor.find(
                resource: 'account',
                id: resource.ledger_id
              )

              response = adaptor.upsert(
                resource: 'account',
                payload: merge_into(from: local_resource_data, to: ledger_resource_data)
              )

              resource.ledger_id = response.dig('Id')
              success(response: response)
            rescue OAuth2::Error => e
              failure(e)
            end

            def local_resource_data
              {
                'Name' => resource.name,
                'AccountSubType' => ACCOUNT_TYPES[resource.account_type]
              }
            end
          end
        end
      end
    end
  end
end