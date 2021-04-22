# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ledger_sync/version'

Gem::Specification.new do |spec|
  spec.name = 'ledger_sync'
  spec.version = LedgerSync.version

  spec.required_ruby_version = '>= 2.5.8'

  # spec.required_rubygems_version = Gem::Requirement.new('>= 0') if spec.respond_to? :required_rubygems_version=
  spec.authors = ['Ryan Jackson']
  spec.date = '2019-05-21'
  spec.description = 'LedgerSync is a simple library that allows you to sync common objects to popular accounting '\
                     'software like QuickBooks Online, Xero, NetSuite, etc.'
  spec.email = ['ryanwjackson@gmail.com']
  spec.homepage = 'https://github.com/LedgerSync/ledger_sync'
  spec.licenses = ['MIT']
  spec.rubygems_version = '3.0.3'
  spec.summary = 'Sync common objects to accounting software.'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency('awesome_print', '>= 0')
  spec.add_development_dependency('bump', '~> 0.9.0')
  spec.add_development_dependency('bundler', '~> 2.1')
  spec.add_development_dependency('byebug', '>= 0')
  spec.add_development_dependency('climate_control')
  # spec.add_development_dependency('coveralls_reborn', '~> 0.20.0')
  spec.add_development_dependency('coveralls')
  spec.add_development_dependency('dotenv')
  spec.add_development_dependency('factory_bot', '~> 6.1.0')
  spec.add_development_dependency('jekyll', '~> 3.8.4')
  spec.add_development_dependency('jekyll-menus', '~> 0.6.0')
  spec.add_development_dependency('jekyll-paginate', '~> 1.1')
  spec.add_development_dependency('jekyll-paginate-v2', '~> 1.9')
  spec.add_development_dependency('overcommit', '~> 0.57.0')
  spec.add_development_dependency('rake', '~> 13.0')
  spec.add_development_dependency('rspec', '~> 3.2')
  spec.add_development_dependency('rubocop', '1.0.0')
  spec.add_development_dependency('simplecov')
  spec.add_development_dependency('simplecov-lcov')
  spec.add_development_dependency('webmock', '>= 0')
  spec.add_runtime_dependency('activemodel', '>= 0')
  spec.add_runtime_dependency('colorize', '>= 0')
  spec.add_runtime_dependency('dry-schema', '~> 1.5.4')
  spec.add_runtime_dependency('dry-validation', '~> 1.5.6')
  spec.add_runtime_dependency('faraday', '>= 0')
  spec.add_runtime_dependency('faraday-detailed_logger', '>= 0')
  spec.add_runtime_dependency('faraday_middleware', '>= 0')
  spec.add_runtime_dependency('fingerprintable', '>= 1.2.1')
  spec.add_runtime_dependency('nokogiri', '>= 0')
  spec.add_runtime_dependency('openssl', '~> 2.2.0')
  spec.add_runtime_dependency('pd_ruby', '>= 0')
  spec.add_runtime_dependency('rack', '~> 2.2.3')
  spec.add_runtime_dependency('resonad', '>= 0')
  spec.add_runtime_dependency('simply_serializable', '>= 1.5.1')
end
