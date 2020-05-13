# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FactoryBot do
  let(:account_name_regex) { /Test Account #{test_run_id}[a-zA-Z0-9]{8}-1/ }
  it 'rewinds' do
    expect(FactoryBot.build(:account).name).to match(account_name_regex)
    FactoryBot.custom_rewind_sequences
    expect(FactoryBot.build(:account).name).to match(account_name_regex)
  end

  it 'supports build' do
    expect(FactoryBot.build(:account).name).to match(account_name_regex)
  end

  it 'supports create' do
    bill = FactoryBot.create(:bill)

    expect(bill.memo).to eq 'Memo 1'
    expect(bill.account.name).to match(account_name_regex)
  end

  it 'supports references_one' do
    expense = FactoryBot.build(:expense)

    expect(expense.currency.symbol).to eq 'ZZZ'
    expect(expense.entity).to be_a(LedgerSync::Bundles::ModernTreasury::Vendor)
    expect(expense.entity.display_name).to match(/Test #{test_run_id}[a-zA-Z0-9]{8}-1 Display Name/)
  end

  it 'supports references_many' do
    expense = FactoryBot.build(:expense)
    expect(expense.line_items.count).to eq(2)
  end
end
