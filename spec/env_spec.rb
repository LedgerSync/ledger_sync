# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ENV do
  it { expect(ENV.fetch('TEST_ENV', nil)).to eq('true') }
end
