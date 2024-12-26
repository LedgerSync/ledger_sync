# frozen_string_literal: true

require 'spec_helper'

# Will check if let_args is defined.
def args_merger(**args)
  defined?(let_args) ? args.merge(let_args) : args
end

# A shared example to test the required fields.
# In case a let variable has to be passed use the block and define it to the hash let_args and
# include the name of the argument in args set to nil.
# (A better way to do this should be found)

RSpec.shared_examples 'a required argument initializer' do |**args|
  describe '#initialize' do
    args.each_key do |key|
      it "should not initialize when #{key} is not provided" do
        expect { described_class.new(**args_merger(**args).reject { |k, _| k == key }) }.to raise_error(ArgumentError)
      end
    end

    it 'should initialize when all required arguments are provided' do
      expect(described_class.new(**args_merger(**args))).to be_truthy
    end
  end
end
