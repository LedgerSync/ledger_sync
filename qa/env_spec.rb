# frozen_string_literal: true

RSpec.describe ENV do
  it { expect(ENV['QA_ENV']).to eq('true') }
end
