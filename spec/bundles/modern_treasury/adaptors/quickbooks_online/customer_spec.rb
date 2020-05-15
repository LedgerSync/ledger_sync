# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Bundles::ModernTreasury::Adaptors::QuickBooksOnline::Customer do
  let(:resource) { LedgerSync::Bundles::ModernTreasury::Customer.new }
  subject { described_class.new(resource: resource) }

  describe '#email' do
    it do
      expect(resource.email).to be_nil
      expect(subject.PrimaryEmailAddr.Address).to be_nil

      resource.email = 'asdf'
      expect(resource.email).to eq('asdf')
      expect(subject.PrimaryEmailAddr.Address).to be_nil

      subject.PrimaryEmailAddr.Address = 'llll'
      expect(subject.PrimaryEmailAddr.Address).to eq('llll')
      expect(subject.resource.email).to eq('llll')
      expect(resource.email).to eq('asdf')
    end
  end
end
