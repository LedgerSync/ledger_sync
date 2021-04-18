# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync do
  it 'has a version number' do
    expect(described_class).to respond_to(:version)
  end

  it 'has a version number in pre release' do
    ClimateControl.modify PRE_RELEASE: 'true' do
      expect(described_class.version).to include('pre')
    end
  end
end
