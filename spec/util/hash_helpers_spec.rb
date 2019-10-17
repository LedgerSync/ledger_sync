# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Util::HashHelpers do
  describe '#deep_merge' do
    it do
      h1 = {
        a: 1,
        b: 2
      }

      h2 = {
        b: 22,
        c: 3
      }

      h = {
        a: 1,
        b: 2,
        c: 3
      }

      expect(described_class.deep_merge(hash_to_merge_into: h2, other_hash: h1)).to eq(h)
    end

    it do
      h1 = {
        a: 1,
        b: { x: 2, y: 3, z: 4 }
      }

      h2 = {
        b: { x: 22, w: 33 },
        c: 3
      }

      h = {
        a: 1,
        b: { x: 2, y: 3, z: 4, w: 33 },
        c: 3
      }

      expect(described_class.deep_merge(hash_to_merge_into: h2, other_hash: h1)).to eq(h)
    end

    it do
      h1 = {
        a: 1,
        b: [2, 3, 4]
      }

      h2 = {
        b: [22],
        c: 3
      }

      h = {
        a: 1,
        b: [2, 3, 4],
        c: 3
      }

      expect(described_class.deep_merge(hash_to_merge_into: h2, other_hash: h1)).to eq(h)
    end

    it do
      h1 = {
        a: 1,
        b: [{ x: 1 }, { y: 2 }]
      }

      h2 = {
        a: 2,
        b: [{ x: 10, xx: 1 }, { y: 20, yy: 2 }],
        c: 3
      }

      h = {
        a: 1,
        b: [{ x: 1 }, { y: 2 }],
        c: 3
      }

      expect(described_class.deep_merge(hash_to_merge_into: h2, other_hash: h1)).to eq(h)
    end

    it do
      h1 = {
        a: 1,
        b: [{ x: 1 }, { y: 2 }]
      }

      h2 = {
        a: 2,
        b: [{ x: 10, xx: 1 }],
        c: 3
      }

      h = {
        a: 1,
        b: [{ x: 1 }, { y: 2 }],
        c: 3
      }

      expect(described_class.deep_merge(hash_to_merge_into: h2, other_hash: h1)).to eq(h)
    end

    it do
      h1 = {
        a: 1,
        b: [{ x: 1 }]
      }

      h2 = {
        a: 2,
        b: [{ x: 10, xx: 1 }, { y: 20, yy: 2 }],
        c: 3
      }

      h = {
        a: 1,
        b: [{ x: 1 }],
        c: 3
      }

      expect(described_class.deep_merge(hash_to_merge_into: h2, other_hash: h1)).to eq(h)
    end
  end
end
