# frozen_string_literal: true

require 'json'
require 'dry-schema'
require 'dry-validation'
require 'logger'
require 'resonad'
require 'uri'
require 'colorize'
require 'fingerprintable'
require 'simply_serializable'

# Version
require 'ledger_sync/version'

# Concerns
require 'ledger_sync/concerns/validatable'

# Extensions
require 'ledger_sync/core_ext/resonad'

# Errors
require 'ledger_sync/error'
Gem.find_files('ledger_sync/error/**/*.rb').each { |path| require path }

# Support Classes
require 'ledger_sync/util/debug'
require 'ledger_sync/util/hash_helpers'
require 'ledger_sync/util/resources_builder'
require 'ledger_sync/adaptor_configuration'
require 'ledger_sync/adaptor_configuration_store'
require 'ledger_sync/util/coordinator'
require 'ledger_sync/util/performer'
require 'ledger_sync/util/validator'
require 'ledger_sync/util/string_helpers'
require 'ledger_sync/result'
require 'ledger_sync/adaptors/operation'
require 'ledger_sync/adaptors/contract'

# Resources (resources are registerd below)
require 'ledger_sync/resource' # Template class
require 'ledger_sync/resources/customer'
require 'ledger_sync/resources/payment'
require 'ledger_sync/resources/vendor'
require 'ledger_sync/resources/expense'

# Synchronizer
require 'ledger_sync/sync'

module LedgerSync
  @log_level = nil
  @logger = nil

  # map to the same values as the standard library's logger
  LEVEL_DEBUG = Logger::DEBUG
  LEVEL_ERROR = Logger::ERROR
  LEVEL_INFO = Logger::INFO

  class << self
    attr_accessor :adaptors, :resources
  end

  def self.log_level
    @log_level
  end

  def self.log_level=(val)
    raise ArgumentError, 'log_level should only be set to `nil`, `debug` or `info`' if !val.nil? && ![LEVEL_DEBUG, LEVEL_ERROR, LEVEL_INFO].include?(val)

    @log_level = val
  end

  def self.logger
    @logger
  end

  def self.logger=(val)
    @logger = val
  end

  def self.register_adaptor(adaptor_key)
    self.adaptors ||= LedgerSync::AdaptorConfigurationStore.new
    self.adaptors.register_adaptor(adaptor_key)
    yield(adaptors.send(adaptor_key))
  end

  def self.register_resource(resource:)
    self.resources ||= {}
    raise "Resource key #{resource.resource_type} already exists." if resources.key?(resource.resource_type)

    self.resources[resource.resource_type] = resource
  end

  def self.root
    File.dirname __dir__
  end
end

# Adaptors
require 'ledger_sync/adaptors/adaptor'
require 'ledger_sync/adaptors/searcher'
Gem.find_files('ledger_sync/adaptors/**/*.rb').each do |path|
  next if path.include?('config.rb')

  require path
end

Gem.find_files('ledger_sync/adaptors/**/config.rb').each { |path| require path }

# Register Resources
LedgerSync.register_resource(resource: LedgerSync::Customer)
LedgerSync.register_resource(resource: LedgerSync::Payment)
LedgerSync.register_resource(resource: LedgerSync::Vendor)
LedgerSync.register_resource(resource: LedgerSync::Expense)
