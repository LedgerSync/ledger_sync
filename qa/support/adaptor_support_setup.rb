# frozen_string_literal: true

def setup_adaptor_support(*adaptors)
  adaptors.each do |adaptor|
    key = adaptor.config.root_key

    support "#{key}_helpers"
    helpers_module  = Object.const_get("#{adaptor.base_module.name.split('::').last}Helpers")
    env_key         = "#{key}_qa".upcase

    RSpec.configure do |config|
      config.include helpers_module, adaptor: key

      config.around(:each, adaptor: key) do |example|
        if ENV.fetch(env_key, nil) == '1'
          example.run
        else
          skip "Set #{env_key}=1 to run #{key} QA tests"
        end
      end
    end
  end
end
