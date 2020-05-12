# frozen_string_literal: true

def setup_connection_qa_support(*connections)
  connections.each do |connection|
    key = connection.config.root_key

    qa_support "#{key}_helpers"
    helpers_module  = Object.const_get("QA::#{connection.base_module.name.split('::').last}Helpers")
    env_key         = "#{key}_qa".upcase

    RSpec.configure do |config|
      config.include helpers_module, qa: true, connection: key

      config.around(:each, qa: true, connection: key) do |example|
        if ENV.fetch(env_key, nil) == '1'
          example.run
        else
          skip "Set #{env_key}=1 to run #{key} QA tests"
        end
      end
    end
  end
end

setup_connection_qa_support(
  *LedgerSync.ledgers.configs.values.map(&:connection_class)
)
