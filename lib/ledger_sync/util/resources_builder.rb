# frozen_string_literal: true

module LedgerSync
  module Util
    class ResourcesBuilder
      attr_reader :cast,
                  :data,
                  :root_resource_external_id,
                  :root_resource_type

      def initialize(cast: true, data:, root_resource_external_id:, root_resource_type:)
        @all_resources = {}
        @cast = cast
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

        current_data = Hash[
          current_data.map do |k, v|
            k = k.to_sym

            attribute = resource_klass.attributes[k]
            next unless attribute.present?

            v = if attribute.reference?
                  resource_or_build(
                    external_id: current_data[k],
                    type: attribute.type.resource_type
                  )
                else
                  cast_value(v, to: attribute.valid_classes.first)
                end

            [k, v]
          end
        ]

        @all_resources[resource_key(external_id: external_id, type: type)] = resource_klass.new(
          external_id: external_id,
          ledger_id: ledger_id,
          **current_data
        )
      end

      def cast_to_date(value)
        case value
        when Date
          value
        when String
          Date.parse(value)
        else
          raise "Do not know how to create a Date from #{value.class}"
        end
      end

      def cast_to_date_time(value)
        case value
        when DateTime
          value
        when String
          DateTime.parse(value)
        else
          raise "Do not know how to create a DateTime from #{value.class}"
        end
      end

      def cast_value(value, to:)
        return value unless cast

        return cast_to_date(value) if to == Date
        return cast_to_date_time(value) if to == DateTime

        value
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
