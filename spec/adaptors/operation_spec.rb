# frozen_string_literal: true

require 'spec_helper'

support :netsuite_helpers

RSpec.describe LedgerSync::Adaptors::Operation do
  include NetSuiteHelpers

  let(:adaptor) { netsuite_adaptor }
  let(:resource) { FactoryBot.create(:customer) }
  let(:operation) do
    adaptor.base_module::Customer::Operations::Create.new(
      adaptor: adaptor,
      resource: resource
    )
  end

  subject { operation }

  it { expect { described_class.new }.to raise_error(NoMethodError) } # Operation is a module

  describe '#failure?' do
    it do
      stub_customer_create
      stub_customer_find
      subject.perform
      expect(subject).not_to be_failure
    end
  end

  describe '#perform' do
    subject { operation.perform }

    it do
      stub_customer_create
      stub_customer_find
      expect(subject).to be_success
    end

    it do
      allow(operation).to receive(:operate) { raise LedgerSync::Error.new(message: 'Test') }
      expect(subject).to be_failure
      expect(subject.error.message).to eq('Test')
    end
  end

  describe '#success?' do
    it do
      stub_customer_create
      stub_customer_find
      subject.perform
      expect(subject).to be_success
    end
  end

  describe '#valid?' do
    it do
      stub_customer_create
      stub_customer_find
      subject.perform
      expect(subject).not_to be_valid
    end
  end
end
