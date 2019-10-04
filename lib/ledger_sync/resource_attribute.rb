# frozen_string_literal: true

require 'ledger_sync/type/value'

Gem.find_files('ledger_sync/type/**/*.rb').each do |path|
  require path
end

Gem.find_files('ledger_sync/resource_attribute/**/*.rb').each do |path|
  require path
end

module LedgerSync
  class ResourceAttribute
    include Fingerprintable::Mixin
    include SimplySerializable::Mixin

    attr_accessor :value
    attr_reader :name,
                :reference,
                :type

    def initialize(name:, type:, value: nil)
      @name = name.to_sym

      type = type.new if type.respond_to?(:new) && !type.is_a?(Type::Value)

      raise "Invalid Type: #{type}" unless type.is_a?(ActiveModel::Type::Value)

      @type = type

      @value = value
    end

    def cast(value)
      type.cast(value)
    end

    # This is for ActiveModel::Dirty, since we define @attributes
    def forgetting_assignment; end

    def reference?
      is_a?(Reference)
    end

    def valid_with?(value:)
      type.valid_without_casting?(value: value)
    end
  end
end
