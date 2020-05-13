# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Deserializer::Delegator do
  let(:custom_resource_class) do
    class_name = "#{test_run_id}TestCustomResource"
    Object.const_unset(class_name)
  rescue NameError
    Object.const_set(
      class_name,
      Class.new(LedgerSync::Resource) do
        attribute :foo, type: LedgerSync::Type::String
        attribute :type, type: LedgerSync::Type::String
      end
    )
  end

  let(:resource) { custom_resource_class.new(foo: 'foo_1') }

  let(:test_deserializer) do
    Class.new(described_class) do
      private

      def deserializer_for(args = {})
        hash = args.fetch(:hash)

        case hash.fetch('type')
        when 'type_1'
          Class.new(LedgerSync::Deserializer) do
            attribute :type, hash_attribute: :type
            attribute :foo, hash_attribute: :bar
          end
        when 'type_2'
          Class.new(LedgerSync::Deserializer) do
            attribute :foo, hash_attribute: :baz
          end
        end
      end
    end
  end

  it do
    h = {
      'bar' => 'bar_value',
      'baz' => 'baz_value',
      'type' => 'type_1'
    }
    deserialized_resource = test_deserializer.new.deserialize(hash: h, resource: resource)
    expect(deserialized_resource.foo).to eq('bar_value')
    expect(deserialized_resource.type).to eq('type_1')
  end

  it do
    h = {
      'bar' => 'bar_value',
      'baz' => 'baz_value',
      'type' => 'type_2'
    }
    deserialized_resource = test_deserializer.new.deserialize(hash: h, resource: resource)
    expect(deserialized_resource.foo).to eq('baz_value')
    expect(deserialized_resource.type).to be_nil
  end
end