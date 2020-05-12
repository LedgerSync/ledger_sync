# frozen_string_literal: true

module LedgerSync
  class LedgerConfiguration
    include Fingerprintable::Mixin
    include SimplySerializable::Mixin

    attr_accessor :module_string,
                  :name,
                  :rate_limiting_wait_in_seconds,
                  :test

    attr_reader :aliases,
                :root_key

    simply_serialize only: %i[
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

    def client_class
      @client_class ||= base_module::Client
    end

    def add_alias(new_alias)
      @aliases << new_alias
      LedgerSync.ledgers.add_alias(new_alias, self)
    end

    def base_module
      @base_module ||= begin
        LedgerSync::Ledgers.const_get(@module_string)
      end
    end

    # Delegate #new to the client class enabling faster client initialization
    # e.g. LedgerSync.ledgers.test.new(...)
    def new(*args)
      client_class.new(*args)
    end

    # Delegate #new_from_env to the client class enabling faster client initialization
    # e.g. LedgerSync.ledgers.test.new_from_env(...)
    def new_from_env(*args)
      client_class.new_from_env(*args)
    end

    def test?
      test == true
    end
  end
end
