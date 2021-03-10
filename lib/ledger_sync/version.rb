# frozen_string_literal: true

module LedgerSync
  VERSION = '1.8.1'

  def self.version
    if !ENV['CI'] || ENV.fetch('GITHUB_REF', '') != ''
      VERSION
    else
      "#{VERSION}.pre.#{ENV['GITHUB_RUN_NUMBER']}"
    end
  end
end
