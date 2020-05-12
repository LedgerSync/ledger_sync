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
require 'oauth2'
require 'tempfile'
require 'pd_ruby'

# Dotenv
require 'dotenv'
Dotenv.load

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
require 'ledger_sync/util/resonad'
require 'ledger_sync/util/signer'
require 'ledger_sync/util/hash_helpers'
require 'ledger_sync/util/read_only_object'
require 'ledger_sync/util/resources_builder'
require 'ledger_sync/ledger_configuration'
require 'ledger_sync/ledger_configuration_store'
require 'ledger_sync/util/performer'
require 'ledger_sync/util/validator'
require 'ledger_sync/util/string_helpers'
require 'ledger_sync/util/mixins/delegate_iterable_methods_mixin'
require 'ledger_sync/util/mixins/dupable_mixin'
require 'ledger_sync/result'
require 'ledger_sync/serializer'
require 'ledger_sync/deserializer'

# Ledgers
Gem.find_files('ledger_sync/ledgers/mixins/**/*.rb').each { |path| require path }
require 'ledger_sync/ledgers/client'
require 'ledger_sync/ledgers/dashboard_url_helper'
require 'ledger_sync/ledgers/searcher'
require 'ledger_sync/ledgers/ledger_serializer'
require 'ledger_sync/ledgers/operation'
require 'ledger_sync/ledgers/contract'
require 'ledger_sync/ledgers/response'
require 'ledger_sync/ledgers/request'

# Resources (resources are registerd below)
require 'ledger_sync/resource' # Template class
Gem.find_files('ledger_sync/resources/**/*.rb').each { |path| require path }

Gem.find_files('ledger_sync/ledgers/quickbooks_online/resources/**/*.rb').each { |path| require path }

module LedgerSync
  @log_level = nil
  @logger = nil

  # map to the same values as the standard library's logger
  LEVEL_DEBUG = Logger::DEBUG
  LEVEL_ERROR = Logger::ERROR
  LEVEL_INFO = Logger::INFO

  class << self
    attr_accessor :ledgers, :resources
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

  def self.register_client(client_key, module_string: nil)
    client_root_path = "ledger_sync/ledgers/#{client_key}"
    require "#{client_root_path}/client"
    self.ledgers ||= LedgerSync::LedgerConfigurationStore.new
    ledger_config = LedgerSync::LedgerConfiguration.new(client_key, module_string: module_string)
    yield(ledger_config)
    self.ledgers.register_client(ledger_config: ledger_config)

    client_files = Gem.find_files("#{client_root_path}/**/*.rb")
    # Sort the files to include BFS-style as most dependencies are in parent folders
    client_files.sort { |a, b| a.count('/') <=> b.count('/') }.each do |path|
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

# Load Ledgers
Gem.find_files('ledger_sync/ledgers/**/config.rb').each { |path| require path }

# Register Resources
LedgerSync.register_resource(resource: LedgerSync::Account)
LedgerSync.register_resource(resource: LedgerSync::Bill)
LedgerSync.register_resource(resource: LedgerSync::BillLineItem)
LedgerSync.register_resource(resource: LedgerSync::Currency)
LedgerSync.register_resource(resource: LedgerSync::Customer)
LedgerSync.register_resource(resource: LedgerSync::Department)
LedgerSync.register_resource(resource: LedgerSync::Deposit)
LedgerSync.register_resource(resource: LedgerSync::DepositLineItem)
LedgerSync.register_resource(resource: LedgerSync::Expense)
LedgerSync.register_resource(resource: LedgerSync::ExpenseLineItem)
LedgerSync.register_resource(resource: LedgerSync::Invoice)
LedgerSync.register_resource(resource: LedgerSync::InvoiceSalesLineItem)
LedgerSync.register_resource(resource: LedgerSync::Item)
LedgerSync.register_resource(resource: LedgerSync::JournalEntry)
LedgerSync.register_resource(resource: LedgerSync::JournalEntryLineItem)
LedgerSync.register_resource(resource: LedgerSync::LedgerClass)
LedgerSync.register_resource(resource: LedgerSync::Payment)
LedgerSync.register_resource(resource: LedgerSync::PaymentLineItem)
LedgerSync.register_resource(resource: LedgerSync::Transfer)
LedgerSync.register_resource(resource: LedgerSync::Vendor)
LedgerSync.register_resource(resource: LedgerSync::Location)

LedgerSync.register_resource(resource: LedgerSync::Ledgers::QuickBooksOnline::Preferences)
