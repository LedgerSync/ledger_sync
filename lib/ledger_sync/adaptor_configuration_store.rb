module LedgerSync
  class AdaptorConfigurationStore
    include Enumerable

    attr_reader :configs, :inflections

    def initialize
      @keys = []
      @configs = {}
      @inflections = []
      @class_configs = {}
    end

    def add_alias(adaptor_key, existing_config)
      if respond_to?(adaptor_key)
        raise LedgerSync::ConfigurationError, "Alias already taken: #{adaptor_key}" if send(adaptor_key) != existing_config

        return
      end

      _instance_methods_for(adaptor_key: adaptor_key, adaptor_config: existing_config)
    end

    def config_from_class(adaptor_class:)
      @class_configs.fetch(adaptor_class)
    end

    def each
      configs.each { |k, v| yield(k, v) }
    end

    def register_adaptor(adaptor_config:)
      _instance_methods_for(
        adaptor_key: adaptor_config.root_key,
        adaptor_config: adaptor_config
      )
    end

    private

    def _instance_methods_for(adaptor_key:, adaptor_config:)
      @keys << adaptor_key.to_sym

      @configs[adaptor_key] = adaptor_config
      @class_configs[adaptor_config.adaptor_class] = adaptor_config

      instance_variable_set(
        "@#{adaptor_key}",
        adaptor_config
      )

      @inflections |= [adaptor_config.module_string]
      self.class.class_eval { attr_reader adaptor_key }
    end
  end
end
