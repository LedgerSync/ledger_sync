# frozen_string_literal: true

module LedgerSync
  module Util
    class ReadOnlyObject
      attr_reader :raw

      def initialize(args = {})
        @raw = args.with_indifferent_access

        self.class.attributes.except { |k, _| e.to_sym == :raw }.each do |name, attr_settings|
          if attr_settings.key?(:default)
            instance_variable_set(
              "@#{name}",
              raw.fetch(name, attr_settings[:default])
            )
          else
            instance_variable_set(
              "@#{name}",
              raw.fetch(attr_settings.fetch(:source, name))
            )
          end
        end
      end

      def ==(other)
        self.class.attributes.keys.all? { |name| send(name) == other.send(name) }
      end

      def self.attributes
        @attributes ||= {}
      end

      def self.attribute(name, **keywords)
        attributes[name.to_sym] = keywords
        attr_reader name
      end

      def self.new_from_array(data)
        data.map { |e| new_from_hash(e) }
      end

      def self.new_from_hash(data)
        new(
          data.symbolize_keys
        )
      end

      def self.source_keys
        @source_keys ||= attributes.map { |k, v| v.fetch(:source, k).to_sym }
      end
    end
  end
end
