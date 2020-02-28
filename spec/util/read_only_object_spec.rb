 # frozen_string_literal: true

require 'spec_helper'

support :netsuite_helpers

RSpec.describe LedgerSync::Util::ReadOnlyObject do
  include NetSuiteHelpers

  let!(:klass1) do
    Class.new(described_class) do
      attribute :foo, default: 1
      attribute :bar, default: :asdf
    end
  end

  let!(:klass2) do
    Class.new(described_class) do
      attribute :baz
    end
  end

  it { expect(klass1.attributes).not_to eq(klass2.attributes) }

  describe '.new' do
    it { expect(klass1.new.foo).to eq(1) }
    it { expect(klass1.new(foo: 999).foo).to eq(999) }
    it { expect(klass1.new.bar).to eq(:asdf) }
  end

  describe '#==' do
    it do
      expect(klass1.new).to eq(klass1.new)
    end

    it do
      expect(klass1.new(foo: 'asdf')).not_to eq(klass1.new)
    end
  end
end
