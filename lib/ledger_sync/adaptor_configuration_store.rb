module LedgerSync
  class AdaptorConfigurationStore
    include Enumerable

    attr_reader :configs

    def initialize
      @keys = []
      @configs = {}
      @klass_configs = {}
    end

    def add_alias(adaptor_key, existing_config)
      if respond_to?(adaptor_key)
        raise LedgerSync::ConfigurationError, "Alias already taken: #{adaptor_key}" if send(adaptor_key) != existing_config

        return
      end

      instance_methods_for(adaptor_key, existing_config)
    end

    def config_from_klass(klass:)
      @klass_configs.fetch(klass)
    end

    def each
      configs.each { |k, v| yield(k, v) }
    end

    def register_adaptor(adaptor_key)
      instance_methods_for(adaptor_key)
    end

    private

    def instance_methods_for(adaptor_key, existing_config = nil)
      @keys << adaptor_key.to_sym

      config = existing_config || LedgerSync::AdaptorConfiguration.new(adaptor_key)
      @configs[adaptor_key] = config
      @klass_configs[config.adaptor_klass] = config

      instance_variable_set(
        "@#{adaptor_key}",
        config
      )

      self.class.class_eval { attr_reader adaptor_key }
    end
  end
end
