 # frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Util::URLHelpers do
  describe '#merge_params_in_path' do
    it do
      path = '/test/foo'
      params = {
        b: 2,
        c: 'asdf'
      }

      merged = described_class.merge_params_in_path(
        path: path,
        params: params
      )
      expect(merged).to eq('/test/foo?b=2&c=asdf')
    end

    it do
      path = '/test/foo?'
      params = {
        b: 2,
        c: 'asdf'
      }

      merged = described_class.merge_params_in_path(
        path: path,
        params: params
      )
      expect(merged).to eq('/test/foo?b=2&c=asdf')
    end

    it do
      path = '/test/foo?a=b'
      params = {
        b: 2,
        c: 'asdf'
      }

      merged = described_class.merge_params_in_path(
        path: path,
        params: params
      )
      expect(merged).to eq('/test/foo?a=b&b=2&c=asdf')
    end

    it do
      path = '/test/foo?b=b'
      params = {
        b: 2,
        c: 'asdf'
      }

      merged = described_class.merge_params_in_path(
        path: path,
        params: params
      )
      expect(merged).to eq('/test/foo?b=2&c=asdf')
    end
  end
end
