# frozen_string_literal: true

require 'factory_bot'

def register_factory(args = {}) # rubocop:disable Metrics/CyclomaticComplexity,Metrics/PerceivedComplexity
  prefix         = args.fetch(:prefix)
  resource_class = args.fetch(:resource_class)
  key            = "#{prefix}_#{resource_class.resource_type}"

  FactoryBot.define do
    factory key, class: resource_class do
      resource_class.resource_attributes.each do |attribute, resource_attribute|
        case resource_attribute.type
        when LedgerSync::Type::StringFromSet
          add_attribute(attribute) { resource_attribute.type.values.first }
        when LedgerSync::Type::String, LedgerSync::Type::ID
          case attribute.to_sym
          when :ledger_id
            sequence(attribute) { nil }
          else # when :external_id or something else
            sequence(attribute) { |n| "#{attribute}-#{rand_id(n)}" }
          end
        when LedgerSync::Type::Float
          add_attribute(attribute) { 1.23 }
        when LedgerSync::Type::Boolean
          add_attribute(attribute) { false }
        when LedgerSync::Type::Date
          add_attribute(attribute) { Date.today }
        when LedgerSync::Type::Hash
          add_attribute(attribute) { {} }
        when LedgerSync::Type::Integer
          add_attribute(attribute) { 123 }
        when LedgerSync::Type::ReferenceOne
          key_ending = if resource_attribute.type.resource_class.is_a?(Array)
                         resource_attribute.type.resource_class.first.resource_type
                       else
                         resource_attribute.type.resource_class.resource_type
                       end
          resource_attribute_key = "#{prefix}_#{key_ending}"
          next if resource_attribute_key == key

          references_one attribute, factory: resource_attribute_key
        when LedgerSync::Type::ReferenceMany
          key_ending = if resource_attribute.type.resource_class.is_a?(Array)
                         resource_attribute.type.resource_class.first.resource_type
                       else
                         resource_attribute.type.resource_class.resource_type
                       end
          resource_attribute_key = "#{prefix}_#{key_ending}"
          next if resource_attribute_key == key

          references_many attribute, factory: resource_attribute_key
        else
          raise "Do not know how to default type: #{resource_attribute.type.class.name}"
        end
      end
    end
  end
end

def generate_resource_factories
  LedgerSync.ledgers.each do |ledger_key, ledger|
    ledger.client_class.resources.each do |resource_key, resource_class|
      factory_key = "#{ledger_key}_#{resource_key}".to_sym
      next if FactoryBot.factories.registered?(factory_key)

      register_factory(prefix: ledger_key, resource_class: resource_class)
    end
  end
end

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.before(:suite) do
    FactoryBot.find_definitions
    generate_resource_factories
  end
  config.after { FactoryBot.rewind_sequences }
end

FactoryBot.define do
  skip_create
  initialize_with { new(attributes) } # Allows initializing read-only attrs
end

module FactoryBot
  def self.rand_id(*appends, include_test_run_id: true)
    ret = ''
    ret += test_run_id if include_test_run_id
    ret += (0...8).map { rand(65..90).chr }.join
    appends.each do |append|
      ret += "-#{append}"
    end
    ret
  end

  def self.test_run_id(*appends, **keywords)
    @test_run_id ||= rand_id(
      *appends,
      **keywords.merge(include_test_run_id: false)
    )
  end

  class DefinitionProxy
    #
    # Helper method of our references_one on resources
    #
    # @param [String] name
    # @param [String] factory Defaults to name
    #
    # @return [FactoryBot::Declaration]
    #
    def references_one(name, factory: nil)
      add_attribute(name) do
        factory ||= name
        FactoryBot.build(factory, **attributes_for(factory))
      end
    end

    #
    # Helper method of our references_many on resources
    #
    # @param [String] name
    # @param [String] factory Defaults to name
    #
    # @return [FactoryBot::Declaration]
    #
    def references_many(name, count: 0, factory: nil)
      add_attribute(name) do
        factory ||= name
        FactoryBot.build_list(factory, count)
      end
    end
  end
end

#
# Used for uniqueness in QuickBooks Online given the unique name requirement
#
# @return [String]
#
def rand_id(*args)
  FactoryBot.rand_id(*args)
end

#
# Used for uniqueness in QuickBooks Online given the unique name requirement
#
# @return [String]
#
def test_run_id(*args)
  @test_run_id ||= FactoryBot.test_run_id(*args)
end
