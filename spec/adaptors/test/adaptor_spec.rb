# frozen_string_literal: true

require 'spec_helper'

support :test_adaptor_helpers

RSpec.describe LedgerSync::Adaptors::Test::Adaptor do
  include TestAdaptorHelpers

  subject { test_adaptor }

  describe '#refresh!' do
    it { expect(subject.fingerprint).to eq(test_adaptor.fingerprint) }
  end

  describe '#ledger_attributes_to_save' do
    it { expect(subject.ledger_attributes_to_save).to eq({}) }
  end
end
