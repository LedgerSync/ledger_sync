# frozen_string_literal: true

require 'spec_helper'

module LedgerSync
  RSpec.describe Validatable do
    let(:non_validatable) do
      Class.new do
        include Validatable

        attr_accessor :foo
      end
    end

    let(:validatable) do
      Class.new do
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

    subject { validatable.new }

    it { expect { non_validatable.new.valid? }.to raise_error(NotImplementedError) }

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
end
