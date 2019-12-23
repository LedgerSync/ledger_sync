# frozen_string_literal: true

require 'factory_bot'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.before(:suite) { FactoryBot.find_definitions }
  config.after do
    FactoryBot.rewind_sequences
  end
end

FactoryBot.configuration.skip_create
FactoryBot.configuration.initialize_with { new(attributes) } # Allows initializing read-only attrs

module FactoryBot
  class DefinitionProxy
    def references_one(name, factory: nil)
      factory ||= name
      add_attribute(name) { FactoryBot.build(factory, **attributes_for(name)) }
    end
  end
end
