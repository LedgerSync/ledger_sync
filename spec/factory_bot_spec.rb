# frozen_string_literal: true

require 'spec_helper'

RSpec.describe FactoryBot do
  it 'rewinds' do
    expect(FactoryBot.build(:account).name).to eq 'Test Account 1'
    FactoryBot.rewind_sequences
    expect(FactoryBot.build(:account).name).to eq 'Test Account 1'
  end

  it 'supports build' do
    expect(FactoryBot.build(:account).name).to eq 'Test Account 1'
  end

  it 'supports create' do
    bill = FactoryBot.create(:bill)

    expect(bill.memo).to eq 'Memo 1'
    expect(bill.account.name).to eq 'Test Account 1'
  end

  it 'supports constructing nested models' do
    bill = FactoryBot.build(:bill)

    expect(bill.memo).to eq 'Memo 1'
    expect(bill.account.name).to eq 'Test Account 1'
  end
end
