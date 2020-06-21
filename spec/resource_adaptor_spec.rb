# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::ResourceAdaptor do
  describe '.new' do
    it { expect { described_class.new }.to raise_error(NotImplementedError) }
  end
end
