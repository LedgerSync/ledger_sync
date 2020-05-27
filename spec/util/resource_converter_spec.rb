# frozen_string_literal: true

require 'spec_helper'

require 'ledger_sync/util/resource_converter'

RSpec.describe LedgerSync::Util::ResourceConverter do
  let(:converter_class) do
    klass = Class.new(described_class)

    # Standard attributes
    klass.attribute :foo_to, source_attribute: :foo_from
    klass.attribute :bar_to, source_attribute: :bar_from

    # references_one
    klass.references_one :ref_one_to,
                         resource_converter: sub_converter_class,
                         source_attribute: :ref_one_from

    # references_many
    klass.references_many :ref_many_to,
                          resource_converter: sub_converter_class,
                          source_attribute: :ref_many_from

    # Block argument that must return the modified destination
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

  let(:sub_converter_class) do
    klass = Class.new(described_class)

    # Standard attributes
    klass.attribute :ledger_id
    klass.attribute :external_id

    klass
  end

  let(:sub_resource_class) do
    new_resource_class
  end

  let(:converter) { converter_class.new }
  let(:converted) { converter.convert(destination: destination, source: source) }

  def build_resource(args)
    converted_args = Hash[args.map do |k, v|
      v = case v
          when Array
            v.map { |e| sub_resource_class.new(e) }
          when Hash
            sub_resource_class.new(v)
          else
            v
          end

      [k, v]
    end]

    new_resource_class(
      attributes: args.select { |_, v| !v.is_a?(Array) && !v.is_a?(Hash) }.keys,
      reference_class: sub_resource_class,
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

  def expect_hash_values
    expect(destination.fetch(:foo_to)).not_to eq('foo_from_val')
    expect(converted.fetch('foo_to')).to eq('foo_from_val')

    expect(destination.fetch(:bar_to)).not_to eq('bar_from_val')
    expect(converted.fetch('bar_to')).to eq('bar_from_val')

    expect(destination.fetch(:baz_to)).not_to eq('baz_from_val')
    expect(converted.fetch('baz_to')).to eq('baz_from_val')

    expect(destination.fetch(:no_change)).to eq('asdf')
    expect(converted.fetch('no_change')).to eq('asdf')

    expect(destination.fetch(:ref_one_to).fetch(:ledger_id, 'not_present')).to eq('not_present')
    expect(converted.fetch('ref_one_to').fetch('ledger_id')).to eq('ref_one_ledger_id')

    expect(destination.fetch(:ref_one_to).fetch(:external_id, 'not_present')).to eq('not_present')
    expect(converted.fetch('ref_one_to').fetch('external_id')).to eq('ref_one_external_id')

    expect(destination.fetch(:ref_many_to)).to be_empty
    expect(converted.fetch('ref_many_to').first.fetch('ledger_id')).to eq('ref_many_ledger_id_1')

    expect(converted.fetch('ref_many_to').first.fetch('external_id')).to eq('ref_many_external_id_1')
  end

  def expect_resource_values
    expect(destination.send(:foo_to)).not_to eq('foo_from_val')
    expect(converted.send('foo_to')).to eq('foo_from_val')

    expect(destination.send(:bar_to)).not_to eq('bar_from_val')
    expect(converted.send('bar_to')).to eq('bar_from_val')

    expect(destination.send(:baz_to)).not_to eq('baz_from_val')
    expect(converted.send('baz_to')).to eq('baz_from_val')

    expect(destination.send(:no_change)).to eq('asdf')
    expect(converted.send('no_change')).to eq('asdf')

    expect(destination.send(:ref_one_to).send(:ledger_id)).to be_nil
    expect(converted.send('ref_one_to').send('ledger_id')).to eq('ref_one_ledger_id')

    expect(destination.send(:ref_one_to).send(:external_id)).to be_nil
    expect(converted.send('ref_one_to').send('external_id')).to eq('ref_one_external_id')

    expect(destination.send(:ref_many_to)).to be_empty
    expect(converted.send('ref_many_to').first.send('ledger_id')).to eq('ref_many_ledger_id_1')

    expect(converted.send('ref_many_to').first.send('external_id')).to eq('ref_many_external_id_1')
  end

  context 'when destination=hash, source=hash' do
    let(:destination) { destination_hash }
    let(:source) { source_hash }

    it { expect_hash_values }
  end

  context 'when destination=resource, source=hash' do
    let(:destination) { destination_resource }
    let(:source) { source_hash }

    it { expect_resource_values }
  end

  context 'when destination=resource, source=resource' do
    let(:destination) { destination_resource }
    let(:source) { source_resource }

    it { expect_resource_values }
  end

  context 'when destination=hash, source=resource' do
    let(:destination) { destination_hash }
    let(:source) { source_resource }

    it { expect_hash_values }
  end
end
