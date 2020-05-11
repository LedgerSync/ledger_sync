# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Bundles::ModernTreasury::Adaptors::NetSuite::Customer do
  let(:resource) { LedgerSync::Bundles::ModernTreasury::Customer.new }
  subject { described_class.new(resource: resource) }

  describe '#email' do
    it do
      expect(subject.email).to be_nil

      resource.email = 'asdf'
      expect(resource.email).to eq('asdf')
      expect(subject.email).to be_nil

      subject.email = 'llll'
      expect(subject.email).to eq('llll')
      expect(subject.resource.email).to eq('llll')
      expect(resource.email).to eq('asdf')
    end
  end
end
