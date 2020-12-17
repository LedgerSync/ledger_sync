# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Util::ReadOnlyObject do
  let!(:class_1) do
    Class.new(described_class) do
      attribute :foo, default: 1
      attribute :bar, default: :asdf
    end
  end

  let!(:class_2) do
    Class.new(described_class) do
      attribute :baz
    end
  end

  it { expect(class_1.attributes).not_to eq(class_2.attributes) }

  describe '.new' do
    it { expect(class_1.new.foo).to eq(1) }
    it { expect(class_1.new(foo: 999).foo).to eq(999) }
    it { expect(class_1.new.bar).to eq(:asdf) }
  end

  describe '#==' do
    it do
      expect(class_1.new).to eq(class_1.new)
    end

    it do
      expect(class_1.new(foo: 'asdf')).not_to eq(class_1.new)
    end
  end
end
