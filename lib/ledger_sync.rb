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
require 'oauth2'
require 'tempfile'
require 'pd_ruby'

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
require 'ledger_sync/util/url_helpers'
require 'ledger_sync/util/signer'
require 'ledger_sync/util/hash_helpers'
require 'ledger_sync/util/read_only_object'
require 'ledger_sync/util/resources_builder'
require 'ledger_sync/util/dotenv_updator'
require 'ledger_sync/ledger_configuration'
require 'ledger_sync/ledger_configuration_store'
require 'ledger_sync/util/performer'
require 'ledger_sync/util/validator'
require 'ledger_sync/util/string_helpers'
require 'ledger_sync/util/mixins/delegate_iterable_methods_mixin'
require 'ledger_sync/util/mixins/resource_registerable_mixin'
require 'ledger_sync/util/mixins/dupable_mixin'
require 'ledger_sync/result'
require 'ledger_sync/operation'
require 'ledger_sync/resource_adaptor'

Gem.find_files('ledger_sync/type/**/*.rb').each { |path| require path }
Gem.find_files('ledger_sync/serialization/type/**/*.rb').each { |path| require path }
require 'ledger_sync/serializer'
require 'ledger_sync/deserializer'

# Ledgers
Gem.find_files('ledger_sync/ledgers/mixins/**/*.rb').each { |path| require path }
require 'ledger_sync/ledgers/client'
require 'ledger_sync/ledgers/dashboard_url_helper'
require 'ledger_sync/ledgers/searcher'
require 'ledger_sync/ledgers/operation'
require 'ledger_sync/ledgers/contract'
require 'ledger_sync/ledgers/response'
require 'ledger_sync/ledgers/request'

# Resources (resources are registered below)
require 'ledger_sync/resource' # Template class

module LedgerSync
  include Util::Mixins::ResourceRegisterableMixin

  @log_level = nil
  @logger = nil

  # map to the same values as the standard library's logger
  LEVEL_DEBUG = Logger::DEBUG
  LEVEL_ERROR = Logger::ERROR
  LEVEL_INFO = Logger::INFO

  module Test
    def require_spec_helper
      require File.join(LedgerSync.root, 'lib/test/support/spec_helper')
    end
  end

  def self.ledgers
    @ledgers ||= LedgerSync::LedgerConfigurationStore.new
  end

  def self.log_level
    @log_level
  end

  def self.log_level=(val)
    if !val.nil? && ![LEVEL_DEBUG, LEVEL_ERROR, LEVEL_INFO].include?(val)
      raise ArgumentError, 'log_level should only be set to `nil`, `debug` or `info`'
    end

    @log_level = val
  end

  def self.logger
    @logger
  end

  def self.logger=(val)
    @logger = val
  end

  def self.register_ledger(*args)
    ledger_config = LedgerSync::LedgerConfiguration.new(*args)

    yield(ledger_config)

    ledgers.register_ledger(ledger_config: ledger_config)

    client_files = Gem.find_files("#{ledger_config.root_path}/resource.rb")
    client_files |= Gem.find_files("#{ledger_config.root_path}/resources/**/*.rb")
    client_files |= Gem.find_files("#{ledger_config.root_path}/serialization/**/*.rb")
    # Sort the files to include BFS-style as most dependencies are in parent folders
    client_files |= Gem.find_files("#{ledger_config.root_path}/**/*.rb").sort { |a, b| a.count('/') <=> b.count('/') }

    client_files.each do |path|
      next if path.include?('config.rb')

      require path
    end
  end

  def self.root
    File.dirname __dir__
  end
end

# Load Ledgers
Gem.find_files('ledger_sync/ledgers/**/config.rb').each { |path| require path }
