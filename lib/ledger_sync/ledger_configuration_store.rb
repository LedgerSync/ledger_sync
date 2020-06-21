# frozen_string_literal: true

module LedgerSync
  class LedgerConfigurationStore
    include Enumerable

    attr_reader :configs, :inflections

    def initialize
      @keys = []
      @configs = {}
      @inflections = []
      @class_configs = {}
    end

    def add_alias(client_key, existing_config)
      if respond_to?(client_key)
        if send(client_key) != existing_config
          raise LedgerSync::ConfigurationError, "Alias already taken: #{client_key}"
        end

        return
      end

      _instance_methods_for(client_key: client_key, ledger_config: existing_config)
    end

    def config_from_class(client_class:)
      @class_configs.fetch(client_class)
    end

    def each
      configs.each { |k, v| yield(k, v) }
    end

    def register_ledger(ledger_config:)
      _instance_methods_for(
        client_key: ledger_config.root_key,
        ledger_config: ledger_config
      )
    end

    private

    def _instance_methods_for(client_key:, ledger_config:)
      @keys << client_key.to_sym

      @configs[client_key] = ledger_config
      @class_configs[ledger_config.client_class] = ledger_config

      instance_variable_set(
        "@#{client_key}",
        ledger_config
      )

      @inflections |= [ledger_config.module_string]
      self.class.class_eval { attr_reader client_key }
    end
  end
end
