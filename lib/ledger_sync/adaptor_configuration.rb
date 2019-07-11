# frozen_string_literal: true

module LedgerSync
  class AdaptorConfiguration
    include Fingerprintable::Mixin
    include SimplySerializable::Mixin

    attr_accessor :module,
                  :name,
                  :rate_limiting_wait_in_seconds,
                  :test

    attr_reader :aliases,
                :root_key

    serialize only: %i[
      aliases
      module
      root_key
      rate_limiting_wait_in_seconds
      test
    ]

    def initialize(root_key)
      @root_key = root_key
      @aliases = []
      @module = LedgerSync::Util::StringHelpers.camelcase(root_key)
    end

    def adaptor_klass
      @adaptor_klass ||= base_module::Adaptor
    end

    def base_module
      @base_module ||= begin
        LedgerSync::Adaptors.const_get(@module)
      end
    end

    def add_alias(new_alias)
      @aliases << new_alias
      LedgerSync.adaptors.add_alias(new_alias, self)
    end

    # Delegate new to the adaptor class enabling faster adaptor initialization
    # e.g. LedgerSync.adaptors.test.new(...)
    def new(*args)
      adaptor_klass.new(*args)
    end

    def test?
      test == true
    end
  end
end
