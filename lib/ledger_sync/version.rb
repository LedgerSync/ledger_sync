# frozen_string_literal: true

# :nocov:
module LedgerSync
  VERSION = '2.4.0'

  def self.version
    if ENV['PRE_RELEASE']
      "#{VERSION}.pre.#{ENV['GITHUB_RUN_NUMBER']}"
    else
      VERSION
    end
  end
end
# :nocov:
