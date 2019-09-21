module LedgerSync
  module Adaptors
    module QuickBooksOnline
      module Account
        module Mapping
          ACCOUNT_TYPES = {
            'bank' => 'Bank',
            'other_current_assets' => 'Other Current Asset',
            'fixed_asset' => 'Fixed Asset',
            'other_asset' => 'Other Asset'
          }

          ACCOUNT_SUB_TYPES = {
            # Bank
            'cash_on_hand' => 'CashOnHand',
            'checking' => 'Checking',
            'money_market' => 'MoneyMarket',
            'rents_held_in_trust' => 'RentsHeldInTrust',
            'savings' => 'Savings',
            'trust_accounts' => 'TrustAccounts',
            'cash_and_cash_equivalents' => 'CashAndCashEquivalents',
            'other_ear_marked_bank_accounts' => 'OtherEarMarkedBankAccounts',
            # Other Current Asset
            'allowance_for_bad_debts' => 'AllowanceForBadDebts',
            'development_costs' => 'DevelopmentCosts',
            'employee_cash_advances' => 'EmployeeCashAdvances',
            'other_current_assets' => 'OtherCurrentAssets',
            'inventory' => 'Inventory',
            'investment_mortgage_real_estate_loans' => 'Investment_MortgageRealEstateLoans',
            'investment_other' => 'Investment_Other',
            'investment_tax_exempt_securities' => 'Investment_TaxExemptSecurities',
            'investment_us_government_obligations' => 'Investment_USGovernmentObligations',
            'loans_to_officers' => 'LoansToOfficers',
            'loans_to_others' => 'LoansToOthers',
            'loans_to_stockholders' => 'LoansToStockholders',
            'prepaid_expenses' => 'PrepaidExpenses',
            'retainage' => 'Retainage',
            'undeposited_funds' => 'UndepositedFunds',
            'assets_available_for_sale' => 'AssetsAvailableForSale',
            'bal_with_govt_authorities' => 'BalWithGovtAuthorities',
            'called_up_share_capital_not_paid' => 'CalledUpShareCapitalNotPaid',
            'expenditure_authorisations_and_letters_of_credit' => 'ExpenditureAuthorisationsAndLettersOfCredit',
            'global_tax_deferred' => 'GlobalTaxDeferred',
            'global_tax_refund' => 'GlobalTaxRefund',
            'internal_transfers' => 'InternalTransfers',
            'other_consumables' => 'OtherConsumables',
            'provisions_current_assets' => 'ProvisionsCurrentAssets',
            'short_term_investments_in_related_parties' => 'ShortTermInvestmentsInRelatedParties',
            'short_term_loans_and_advances_to_related_parties' => 'ShortTermLoansAndAdvancesToRelatedParties',
            'trade_and_other_receivables' => 'TradeAndOtherReceivables',
            # Fixed Asset
            'accumulated_depletion' => 'AccumulatedDepletion',
            'accumulated_depreciation' => 'AccumulatedDepreciation',
            'depletable_assets' => 'DepletableAssets',
            'fixed_asset_computers' => 'FixedAssetComputers',
            'fixed_asset_copiers' => 'FixedAssetCopiers',
            'fixed_asset_furniture' => 'FixedAssetFurniture',
            'fixed_asset_phone' => 'FixedAssetPhone',
            'fixed_asset_photo_video' => 'FixedAssetPhotoVideo',
            'fixed_asset_software' => 'FixedAssetSoftware',
            'fixed_asset_other_tools_equipment' => 'FixedAssetOtherToolsEquipment',
            'furniture_and_fixtures' => 'FurnitureAndFixtures',
            'land' => 'Land',
            'leasehold_improvements' => 'LeaseholdImprovements',
            'other_fixed_assets' => 'OtherFixedAssets',
            'accumulated_amortization' => 'AccumulatedAmortization',
            'buildings' => 'Buildings',
            'intangible_assets' => 'IntangibleAssets',
            'machinery_and_equipment' => 'MachineryAndEquipment',
            'vehicles' => 'Vehicles',
            'assets_in_course_of_construction' => 'AssetsInCourseOfConstruction',
            'capital_wip' => 'CapitalWip',
            'cumulative_depreciation_on_intangible_assets' => 'CumulativeDepreciationOnIntangibleAssets',
            'intangible_assets_under_development' => 'IntangibleAssetsUnderDevelopment',
            'land_asset' => 'LandAsset',
            'non_current_assets' => 'NonCurrentAssets',
            'participating_interests' => 'ParticipatingInterests',
            'provisions_fixed_assets' => 'ProvisionsFixedAssets',
            # Other Asset
            'lease_buyout' => 'LeaseBuyout',
            'other_long_term_assets' => 'OtherLongTermAssets',
            'security_deposits' => 'SecurityDeposits',
            'accumulated_amortization_of_other_assets' => 'AccumulatedAmortizationOfOtherAssets',
            'goodwill' => 'Goodwill',
            'licenses' => 'Licenses',
            'organizational_costs' => 'OrganizationalCosts',
            'assets_held_for_sale' => 'AssetsHeldForSale',
            'available_for_sale_financial_assets' => 'AvailableForSaleFinancialAssets',
            'deferred_tax' => 'DeferredTax',
            'investments' => 'Investments',
            'long_term_investments' => 'LongTermInvestments',
            'long_term_loans_and_advances_to_related_parties' => 'LongTermLoansAndAdvancesToRelatedParties',
            'other_intangible_assets' => 'OtherIntangibleAssets',
            'other_long_term_investments' => 'OtherLongTermInvestments',
            'other_long_term_loans_and_advances' => 'OtherLongTermLoansAndAdvances',
            'prepayments_and_accrued_income' => 'PrepaymentsAndAccruedIncome',
            'provisions_non_current_assets' => 'ProvisionsNonCurrentAssets',
          }
        end
      end
    end
  end
end