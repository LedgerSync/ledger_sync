# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ENV do
  it { expect(ENV['TEST_ENV']).to eq('true') }
end
