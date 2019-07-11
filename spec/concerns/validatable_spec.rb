require 'spec_helper'

module LedgerSync
  module Test
    class ValidatableTestNoValidate
      include Validatable

      attr_accessor :foo
    end

    class ValidatableTest
      include Validatable

      attr_accessor :foo

      def validate
        if foo == :bar
          Result.Success
        else
          Result.Failure
        end
      end
    end
  end
end

RSpec.describe LedgerSync::Validatable do
  subject { LedgerSync::Test::ValidatableTest.new }

  it { expect { LedgerSync::Test::ValidatableTestNoValidate.new.valid? }.to raise_error(NotImplementedError) }

  describe '#validate' do
    it do
      subject.foo = :bar
      expect(subject).to be_valid
    end

    it do
      subject.foo = nil
      expect(subject).not_to be_valid
    end
  end

  describe '#validate_or_fail' do
    it do
      subject.foo = :bar
      expect(subject.validate_or_fail).to be_success
    end

    it do
      subject.foo = nil
      expect(subject.validate_or_fail).to be_failure
    end
  end
end
