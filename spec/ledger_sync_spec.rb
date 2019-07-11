require 'spec_helper'

RSpec.describe LedgerSync do
  it 'has a version number' do
    expect(LedgerSync::VERSION).not_to be(nil)
  end
end
