require 'byebug'
module LedgerSync
  module Util
    class ResourcesBuilder
      attr_reader :data,
                  :root_resource_external_id,
                  :root_resource_type

      def initialize(data:, root_resource_external_id:, root_resource_type:)
        @all_resources = {}
        @data = Util::HashHelpers.deep_symbolize_keys(data)
        @root_resource_external_id = root_resource_external_id
        @root_resource_type = root_resource_type
      end

      def resource
        @resource ||= build_resource(
          external_id: root_resource_external_id,
          type: root_resource_type
        )
      end

      def resources
        @resources ||= begin
          resource
          @all_resources.values
        end
      end

      private

      def build_resource(external_id:, type:)
        external_id = external_id.to_sym
        type = type.to_sym

        ledger_id = @data.dig(type, external_id, :ledger_id)
        current_data = @data.dig(type, external_id, :data)
        raise "No data provided for #{type} (ID: #{external_id})" if current_data.nil?

        resource_klass = LedgerSync.resources[type]
        raise "#{type} is an invalid resource type" if resource_klass.nil?

        provided_references = resource_klass.references.select { |k, _v| current_data.key?(k) }

        provided_references.each do |reference, reference_klass|
          current_data[reference] = resource_or_build(external_id: current_data[reference], type: reference_klass.resource_type)
        end

        @all_resources[resource_key(external_id: external_id, type: type)] = resource_klass.new(
          external_id: external_id,
          ledger_id: ledger_id,
          **current_data
        )
      end

      def resource_key(external_id:, type:)
        "#{type}/#{external_id}"
      end

      def resource_or_build(**external_id_and_type)
        @all_resources.fetch(
          resource_key(**external_id_and_type),
          build_resource(**external_id_and_type)
        )
      end
    end
  end
end
