# frozen_string_literal: true

module TestLedgerHelpers
  # Ledger
  def test_ledger_module
    LedgerSync.ledgers.test_ledger.base_module
  end

  def test_ledger_client
    LedgerSync.ledgers.test_ledger.new(
      api_key: 'api_key'
    )
  end
end
