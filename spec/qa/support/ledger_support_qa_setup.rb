# frozen_string_literal: true

def setup_client_qa_support(*clients)
  clients.each do |client|
    key = client.config.root_key

    qa_support "#{key}_helpers"
    helpers_module  = Object.const_get("QA::#{client.base_module.name.split('::').last}Helpers")
    env_key         = "#{key}_qa".upcase

    RSpec.configure do |config|
      config.include helpers_module, qa: true, client: key

      config.around(:each, qa: true, client: key) do |example|
        if ENV.fetch(env_key, nil) == '1'
          example.run
        else
          skip "Set #{env_key}=1 to run #{key} QA tests"
        end
      end
    end
  end
end

setup_client_qa_support(
  *LedgerSync.ledgers.configs.values.map(&:client_class)
)
