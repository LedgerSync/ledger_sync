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

    def add_alias(connection_key, existing_config)
      if respond_to?(connection_key)
        raise LedgerSync::ConfigurationError, "Alias already taken: #{connection_key}" if send(connection_key) != existing_config

        return
      end

      _instance_methods_for(connection_key: connection_key, ledger_config: existing_config)
    end

    def config_from_class(connection_class:)
      @class_configs.fetch(connection_class)
    end

    def each
      configs.each { |k, v| yield(k, v) }
    end

    def register_connection(ledger_config:)
      _instance_methods_for(
        connection_key: ledger_config.root_key,
        ledger_config: ledger_config
      )
    end

    private

    def _instance_methods_for(connection_key:, ledger_config:)
      @keys << connection_key.to_sym

      @configs[connection_key] = ledger_config
      @class_configs[ledger_config.connection_class] = ledger_config

      instance_variable_set(
        "@#{connection_key}",
        ledger_config
      )

      @inflections |= [ledger_config.module_string]
      self.class.class_eval { attr_reader connection_key }
    end
  end
end
