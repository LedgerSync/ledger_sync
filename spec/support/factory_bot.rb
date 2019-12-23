# frozen_string_literal: true

require 'factory_bot'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.before(:suite) { FactoryBot.find_definitions }
  config.after { FactoryBot.rewind_sequences }
end

FactoryBot.configuration.skip_create
FactoryBot.configuration.initialize_with { new(attributes) } # Allows initializing read-only attrs

module FactoryBot
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
      factory ||= name
      add_attribute(name) { FactoryBot.build(factory, **attributes_for(name)) }
    end

    #
    # Overwriting method so that it globally registers the sequence.  This is a
    # monkey patch to avoid time digging through the `method_missing` issues.
    #
    # @param [String] name
    # @param [Array] *args
    # @param [Proc] &block
    #
    # @return [FactoryBot::Declaration]
    #
    def sequence(name, *args, &block)
      sequence = Sequence.new(name, *args, &block)
      FactoryBot.register_sequence(sequence)
      add_attribute(name) { increment_sequence(sequence) }
    end
  end
end
