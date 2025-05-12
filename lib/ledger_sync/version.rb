# frozen_string_literal: true

# :nocov:
module LedgerSync
  VERSION = '3.0.3'

  def self.version
    if ENV['PRE_RELEASE']
      "#{VERSION}.pre.#{ENV.fetch('GITHUB_RUN_NUMBER', nil)}"
    else
      VERSION
    end
  end
end
# :nocov:
