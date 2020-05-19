# frozen_string_literal: true

require 'spec_helper'

require 'ledger_sync/util/resource_converter'

RSpec.describe LedgerSync::Util::ResourceConverter do
  let(:converter_class) do
    klass = Class.new(described_class)
    klass.attribute :foo_to, source_attribute: :foo_from
    klass.attribute :bar_to, source_attribute: :bar_from
    klass.attribute do |args = {}|
      destination = args.fetch(:destination)
      source      = args.fetch(:source)

      value = source.is_a?(Hash) ? source['baz_from'] : source.baz_from

      if destination.is_a?(Hash)
        destination['baz_to'] = value
      else
        destination.baz_to = value
      end

      destination
    end

    klass
  end

  let(:converter) { converter_class.new }
  let(:converted) { converter.convert(destination: destination, source: source) }

  def build_resource(args)
    converted_args = Hash[args.map do |k, v|
      v = case v
          when Array
            v.map { |e| LedgerSync::Resource.new(e) }
          when Hash
            LedgerSync::Resource.new(v)
          else
            v
          end

      [k, v]
    end]

    new_resource_class(
      attributes: args.select { |_, v| !v.is_a?(Array) && !v.is_a?(Hash) }.keys,
      references_one: args.select { |_, v| v.is_a?(Hash) }.keys,
      references_many: args.select { |_, v| v.is_a?(Array) }.keys
    ).new(converted_args)
  end

  let(:destination_hash) do
    {
      foo_to: 'foo_to_val',
      bar_to: 'bar_to_val',
      baz_to: 'baz_to_val',
      ref_one_to: {},
      ref_many_to: [],
      no_change: 'asdf'
    }
  end

  let(:destination_resource) do
    build_resource(destination_hash)
  end

  let(:source_hash) do
    {
      foo_from: 'foo_from_val',
      bar_from: 'bar_from_val',
      baz_from: 'baz_from_val',
      ref_one_from: {
        ledger_id: 'ref_one_ledger_id',
        external_id: 'ref_one_external_id'
      },
      ref_many_from: [
        {
          ledger_id: 'ref_many_ledger_id_1',
          external_id: 'ref_many_external_id_1'
        },
        {
          ledger_id: 'ref_many_ledger_id_2',
          external_id: 'ref_many_external_id_2'
        }
      ]
    }
  end

  let(:source_resource) do
    build_resource(source_hash)
  end

  context 'when destination=hash, source=hash' do
    let(:destination) { destination_hash }
    let(:source) { source_hash }

    it do
      expect(converted.fetch('foo_to')).to eq('foo_from_val')
      expect(converted.fetch('bar_to')).to eq('bar_from_val')
      expect(converted.fetch('baz_to')).to eq('baz_from_val')
      expect(converted.fetch('no_change')).to eq('asdf')
    end
  end

  context 'when destination=resource, source=hash' do
    let(:destination) { destination_resource }
    let(:source) { source_hash }

    it do
      expect(converted.foo_to).to eq('foo_from_val')
      expect(converted.bar_to).to eq('bar_from_val')
      expect(converted.baz_to).to eq('baz_from_val')
      expect(converted.no_change).to eq('asdf')
    end
  end

  context 'when destination=resource, source=resource' do
    let(:destination) { destination_resource }
    let(:source) { source_resource }

    it do
      expect(converted.foo_to).to eq('foo_from_val')
      expect(converted.bar_to).to eq('bar_from_val')
      expect(converted.baz_to).to eq('baz_from_val')
      expect(converted.no_change).to eq('asdf')
    end
  end

  context 'when destination=hash, source=resource' do
    let(:destination) { destination_hash }
    let(:source) { source_resource }

    it do
      expect(converted.fetch('foo_to')).to eq('foo_from_val')
      expect(converted.fetch('bar_to')).to eq('bar_from_val')
      expect(converted.fetch('baz_to')).to eq('baz_from_val')
      expect(converted.fetch('no_change')).to eq('asdf')
    end
  end
end
