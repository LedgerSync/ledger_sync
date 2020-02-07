require 'spec_helper'

module LedgerSync
  module TestHelpers
    extend self

    def operations_hash
      @operations_hash ||= begin
        Hash[operation_paths.map do |full_path|
          path = full_path.split('/adaptors/').last
          operation_klass = operation_klass_from(path: path)
          resource_class = operation_klass.inferred_resource_class
          [
            operation_klass,
            {
              full_path: full_path,
              path: path,
              resource_attributes: resource_attributes_for(resource_class: resource_class),
              resource_class: resource_class
            }
          ]
        end]
      end
    end

    def operation_klass_from(path:)
      LedgerSync::Adaptors.const_get(
        LedgerSync::Util::StringHelpers.camelcase(
          path[0..-4]
        )
      )
    end

    def operation_klasses
      @operation_klasses ||= operations_hash.keys
    end

    def operation_paths
      @operation_paths ||= Gem.find_files('ledger_sync/adaptors/**/operations/*.rb')
    end

    def resource_attributes_for(resource_class:)
      return [] if resource_class < LedgerSync::Error

      resource_class.resource_attributes.keys | [:ledger_id]
    end
  end
end

LedgerSync::TestHelpers.operations_hash.each do |operation_klass, operation_meta|
  RSpec.describe operation_klass::Contract do
    include LedgerSync::TestHelpers

    describe "@ #{operation_meta[:full_path]}" do
      context "given #{operation_meta[:resource_class]} attributes" do
        operation_meta[:resource_attributes].each do |attribute|
          it "it validates ##{attribute}" do
            schema_keys = operation_klass.const_get('Contract').new.schema.key_map.map(&:name).map(&:to_sym)
            expect(schema_keys).to include(attribute.to_sym)
          end
        end
      end
    end
  end
end
