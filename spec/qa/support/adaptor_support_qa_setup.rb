# frozen_string_literal: true

def setup_adaptor_qa_support(*adaptors)
  adaptors.each do |adaptor|
    key = adaptor.config.root_key

    qa_support "#{key}_helpers"
    helpers_module  = Object.const_get("QA::#{adaptor.base_module.name.split('::').last}Helpers")
    env_key         = "#{key}_qa".upcase

    RSpec.configure do |config|
      config.include helpers_module, qa: true, adaptor: key

      config.around(:each, qa: true, adaptor: key) do |example|
        if ENV.fetch(env_key, nil) == '1'
          example.run
        else
          skip "Set #{env_key}=1 to run #{key} QA tests"
        end
      end
    end
  end
end

setup_adaptor_qa_support(
  *LedgerSync.adaptors.configs.values.map(&:adaptor_class)
)
