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
require 'active_model'
require 'stripe'
require 'netsuite'

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
require 'ledger_sync/util/performer'
require 'ledger_sync/util/validator'
require 'ledger_sync/util/string_helpers'
require 'ledger_sync/result'
require 'ledger_sync/adaptors/operation'
require 'ledger_sync/adaptors/contract'

# Resources (resources are registerd below)
require 'ledger_sync/resource' # Template class
require 'ledger_sync/resources/account'
require 'ledger_sync/resources/subsidiary'
require 'ledger_sync/resources/customer'
require 'ledger_sync/resources/vendor'
require 'ledger_sync/resources/payment'
require 'ledger_sync/resources/expense_line_item'
require 'ledger_sync/resources/expense'
require 'ledger_sync/resources/deposit_line_item'
require 'ledger_sync/resources/deposit'
require 'ledger_sync/resources/transfer'
require 'ledger_sync/resources/bill_line_item'
require 'ledger_sync/resources/bill'
require 'ledger_sync/resources/journal_entry_line_item'
require 'ledger_sync/resources/journal_entry'

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

  def self.register_adaptor(adaptor_key, module_string: nil)
    adaptor_root_path = "ledger_sync/adaptors/#{adaptor_key}"
    require "#{adaptor_root_path}/adaptor"
    self.adaptors ||= LedgerSync::AdaptorConfigurationStore.new
    adaptor_config = LedgerSync::AdaptorConfiguration.new(adaptor_key, module_string: module_string)
    yield(adaptor_config)
    self.adaptors.register_adaptor(adaptor_config: adaptor_config)

    adaptor_files = Gem.find_files("#{adaptor_root_path}/**/*.rb")
    # Sort the files to include BFS-style as most dependencies are in parent folders
    adaptor_files.sort { |a, b| a.count('/') <=> b.count('/') }.each do |path|
      next if path.include?('config.rb')

      require path
    end
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
require 'ledger_sync/adaptors/ledger_serializer'
Gem.find_files('ledger_sync/adaptors/**/config.rb').each { |path| require path }

# Register Resources
LedgerSync.register_resource(resource: LedgerSync::Account)
LedgerSync.register_resource(resource: LedgerSync::Customer)
LedgerSync.register_resource(resource: LedgerSync::Vendor)
LedgerSync.register_resource(resource: LedgerSync::Payment)
LedgerSync.register_resource(resource: LedgerSync::ExpenseLineItem)
LedgerSync.register_resource(resource: LedgerSync::Expense)
LedgerSync.register_resource(resource: LedgerSync::DepositLineItem)
LedgerSync.register_resource(resource: LedgerSync::Deposit)
LedgerSync.register_resource(resource: LedgerSync::Transfer)
LedgerSync.register_resource(resource: LedgerSync::BillLineItem)
LedgerSync.register_resource(resource: LedgerSync::Bill)
LedgerSync.register_resource(resource: LedgerSync::JournalEntryLineItem)
LedgerSync.register_resource(resource: LedgerSync::JournalEntry)
