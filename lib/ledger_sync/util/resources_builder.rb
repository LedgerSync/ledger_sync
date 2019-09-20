# frozen_string_literal: true

module LedgerSync
  module Util
    class ResourcesBuilder
      attr_reader :cast,
                  :data,
                  :ignore_unrecognized_attributes,
                  :root_resource_external_id,
                  :root_resource_type

      def initialize(cast: true, data:, ignore_unrecognized_attributes: false, root_resource_external_id:, root_resource_type:)
        @all_resources = {}
        @cast = cast
        @data = Util::HashHelpers.deep_symbolize_keys(data)
        @ignore_unrecognized_attributes = ignore_unrecognized_attributes
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

        resource_class = LedgerSync.resources[type]
        raise "#{type} is an invalid resource type" if resource_class.nil?

        current_data = Hash[
          current_data.map do |k, v|
            k = k.to_sym

            attribute = resource_class.attributes[k]
            raise 'Unrecognized attribute' if attribute.nil? && !ignore_unrecognized_attributes

            v = if attribute.is_a?(ResourceAttribute::Reference::One)
                  resource_or_build(
                    external_id: current_data[k],
                    type: attribute.type.resource_class.resource_type
                  )
                elsif attribute.is_a?(ResourceAttribute::Reference::Many)
                  current_data[k].map do |many_reference|
                    resource_or_build(
                      external_id: many_reference,
                      type: attribute.type.resource_class.resource_type
                    )
                  end
                elsif cast
                  attribute.type.cast(v)
                else
                  v
                end

            [k, v]
          end
        ]

        @all_resources[resource_key(external_id: external_id, type: type)] ||= resource_class.new(
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
