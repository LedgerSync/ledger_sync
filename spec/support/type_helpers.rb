# frozen_string_literal: true

module TypeHelpers # rubocop:disable Metrics/ModuleLength
  TYPE_VALUES = {
    date: Date.current,
    empty_string: '',
    falsey: false,
    float: 123.4,
    hash: { a: 1 },
    integer: 123,
    nil: nil,
    string: 'String Value',
    truthy: true
  }.freeze

  module ClassMethods
    def it_behaves_like_a_type_with_valid_types_of(*valid_types)
      raise "valid_types must be an array of symbols. Received: #{valid_types.class}" unless valid_types.is_a?(Array)
      raise "valid_types must contain one or more types: #{TYPE_VALUES.keys.sort.join(', ')}" if valid_types.empty?


      valid_types |= [:nil] # nil should always be valid and return nil

      valid_types.each do |type_key|
        if type_key.is_a?(Array)
          type_key, type_input, type_output = type_key
        else
          type_input = type_output = TYPE_VALUES.fetch(type_key.to_sym)
        end

        it "is valid with #{type_key} type" do
          expect(type.cast(value: type_input)).to eq(type_output)
        end
      end

      TYPE_VALUES.except(*valid_types).each do |type_key, type_value|
        it "is invalid with #{type_key} type" do
          expect { type.cast(value: type_value) }.to raise_error(LedgerSync::Error::TypeError::ValueClassError)
        end
      end
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
    base.let(:type) { described_class.new }
  end
end
