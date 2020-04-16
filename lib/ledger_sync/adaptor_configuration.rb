# frozen_string_literal: true

module LedgerSync
  class AdaptorConfiguration
    include Fingerprintable::Mixin
    include SimplySerializable::Mixin

    attr_accessor :module_string,
                  :name,
                  :rate_limiting_wait_in_seconds,
                  :test

    attr_reader :aliases,
                :root_key

    serialize only: %i[
      aliases
      module_string
      root_key
      rate_limiting_wait_in_seconds
      test
    ]

    def initialize(root_key, module_string: nil)
      @root_key = root_key
      @aliases = []
      @module_string = module_string || LedgerSync::Util::StringHelpers.camelcase(root_key)
    end

    def adaptor_class
      @adaptor_class ||= base_module::Adaptor
    end

    def add_alias(new_alias)
      @aliases << new_alias
      LedgerSync.adaptors.add_alias(new_alias, self)
    end

    def base_module
      @base_module ||= begin
        LedgerSync::Adaptors.const_get(@module_string)
      end
    end

    # Delegate #new to the adaptor class enabling faster adaptor initialization
    # e.g. LedgerSync.adaptors.test.new(...)
    def new(*args)
      adaptor_class.new(*args)
    end

    # Delegate #new_from_env to the adaptor class enabling faster adaptor initialization
    # e.g. LedgerSync.adaptors.test.new_from_env(...)
    def new_from_env(*args)
      adaptor_class.new_from_env(*args)
    end

    def test?
      test == true
    end
  end
end
