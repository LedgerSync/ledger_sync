# frozen_string_literal: true

module LedgerSync
  VERSION = '1.8.1'

  def self.version
    if !ENV['TRAVIS'] || ENV.fetch('TRAVIS_TAG', '') != ''
      VERSION
    else
      "#{VERSION}.pre.#{ENV['TRAVIS_BUILD_NUMBER']}"
    end
  end
end
