# frozen_string_literal: true

def setup_client_qa_support(*clients, keyed: false) # rubocop:disable Metrics/PerceivedComplexity
  qa_clients = Hash[clients.uniq.map do |client|
    key = client.config.root_key

    qa_support "#{key}_helpers"

    [
      client,
      {
        env_key: "#{key}_qa".upcase,
        helpers_module: Object.const_get("QA::#{client.base_module.name.split('::').last}Helpers"),
        key: key
      }
    ]
  end]

  RSpec.configure do |config|
    qa_clients.each_value do |data|
      if keyed
        config.include data[:helpers_module], qa: true, client: data[:key]
      else
        config.include data[:helpers_module], qa: true
      end
    end

    config.around(:each, qa: true) do |example|
      described_class = example.metadata[:described_class]
      config = if described_class.respond_to?(:config)
                 described_class.config
               else
                 described_class.inferred_config
               end
      client_key = example.metadata.fetch(:client, config.root_key)

      env_key = "#{client_key}_QA".upcase

      if ENV.fetch(env_key, nil) == '1'
        ClimateControl.modify(Dotenv.parse(ENV.fetch('LOCAL_DOTENV_PATH', '.env.local'))) do
          example.run
        end
      else
        skip "Set #{env_key}=1 to run #{client_key} QA tests"
      end
    end
  end
end
