# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "ledger_sync/ledgers/xero/version"

Gem::Specification.new do |spec|
  spec.name = "ledger_sync-xero"
  spec.version = LedgerSync::Ledgers::Xero::VERSION
  spec.authors = ["Jozef Vaclavik"]
  spec.email = ["jozef@hey.com"]

  spec.summary = 'Sync common objects to accounting software.'
  spec.description = 'LedgerSync is a simple library that allows you to sync common objects to popular accounting '\
                     'software like QuickBooks Online, Xero, NetSuite, etc.'
  spec.homepage = 'https://github.com/LedgerSync/ledger_sync'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency('ledger_sync', '~> 1.4')
  spec.add_development_dependency('bundler', '~> 2.1')
  spec.add_development_dependency('rake', '~> 13.0')
  spec.add_development_dependency('rspec', '~> 3.2')
  spec.add_runtime_dependency('dotenv')
  spec.add_runtime_dependency('nokogiri', '>= 0')
  spec.add_runtime_dependency('oauth2', '>= 0')
end
