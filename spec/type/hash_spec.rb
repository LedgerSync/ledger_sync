# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Type::Hash do
  let(:type) { described_class.new }

  describe 'casting' do
    let(:string_value) { 'String Value' }
    let(:nil_value) { nil }
    let(:integer_value) { 123 }
    let(:float_value) { 123.4 }
    let(:date_value) { Date.current }
    let(:hash_value) { { a: 1 } }
    let(:truthy_value) { true }
    let(:falsy_value) { false }

    it 'matching return hash' do
      expect(type.cast(value: hash_value)).to eq(hash_value)
    end

    it 'nil return nil' do
      expect(type.cast(value: nil_value)).to eq(nil_value)
    end

    it 'mismatch raise exception' do
      expect { type.cast(value: string_value) }.to raise_error(LedgerSync::Error::TypeError::ValueClassError)
      expect { type.cast(value: integer_value) }.to raise_error(LedgerSync::Error::TypeError::ValueClassError)
      expect { type.cast(value: float_value) }.to raise_error(LedgerSync::Error::TypeError::ValueClassError)
      expect { type.cast(value: date_value) }.to raise_error(LedgerSync::Error::TypeError::ValueClassError)
      expect { type.cast(value: truthy_value) }.to raise_error(LedgerSync::Error::TypeError::ValueClassError)
      expect { type.cast(value: falsy_value) }.to raise_error(LedgerSync::Error::TypeError::ValueClassError)
    end
  end
end
