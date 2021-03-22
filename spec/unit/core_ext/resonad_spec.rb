# frozen_string_literal: true

require 'spec_helper'

class Resonad
  RSpec.describe Success do
    describe 'raise_if_error' do
      it do
        r = described_class.new('asdf')
        expect(r.raise_if_error).to be_success
      end
    end
  end

  RSpec.describe Failure do
    describe 'raise_if_error' do
      it do
        error = StandardError.new(message: 'asdf')
        r = described_class.new(error)
        expect { r.raise_if_error }.to raise_error(error)
      end
    end
  end
end
