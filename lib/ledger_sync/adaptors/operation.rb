# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module Operation
      TYPES = %i[create find update upsert].freeze

      module Mixin
        module ClassMethods
          def adaptor_klass
            @adaptor_klass ||= Class.const_get("#{name.split('::')[0..2].join('::')}::Adaptor")
          end

          def resource_klass
            @resource_klass ||= LedgerSync.const_get(
              name
                .split("#{adaptor_klass.config.base_module.name}::")
                .last
                .split('::Operations')
                .first
            )
          end
        end

        def self.included(base)
          base.include SimplySerializable::Mixin
          base.include Fingerprintable::Mixin
          # base.include Validatable
          base.extend ClassMethods

          base.class_eval do
            serialize do_not_serialize_if_class_is: [Date, DateTime, Time],
                      only: %i[
                        adaptor
                        after_operations
                        before_operations
                        operations
                        resource
                        root_operation
                        result
                        response
                        original
                      ]
          end
        end

        attr_reader :adaptor,
                    :after_operations,
                    :before_operations,
                    :operations,
                    :resource,
                    :root_operation,
                    :result,
                    :response,
                    :original

        def initialize(adaptor:, resource:)
          raise 'Missing adaptor' if adaptor.nil?
          raise 'Missing resource' if resource.nil?

          raise "#{resource.class.name} is not a valid resource type.  Expected #{self.class.resource_klass.name}" unless resource.is_a?(self.class.resource_klass)

          @adaptor = adaptor
          @after_operations = []
          @before_operations = []
          @operations = []
          @resource = resource
          @result = nil
          @root_operation = nil
        end

        def add_after_operation(operation)
          @operations << operation
          @after_operations << operation
        end

        def add_before_operation(operation)
          @operations << operation
          @before_operations << operation
        end

        def add_root_operation(operation)
          @operations << operation
          @root_operation = operation
        end

        def perform
          failure(LedgerSync::Error::OperationError::PerformedOperationError.new(operation: self)) if @performed

          begin
            operate
          rescue LedgerSync::Error => e
            failure(e)
          rescue StandardError => e
            parsed_error = adaptor.parse_operation_error(error: e, operation: self)
            raise e unless parsed_error

            failure(parsed_error)
          ensure
            @performed = true
          end
        end

        def performed?
          @performed == true
        end

        def prepare
          build
        end

        # Results

        def failure(error)
          @result = LedgerSync::OperationResult.Failure(
            error,
            operation: self,
            response: error
          )
        end

        def failure?
          result.failure?
        end

        def success(response:)
          @result = LedgerSync::OperationResult.Success(
            self,
            operation: self,
            response: response
          )
        end

        def success?
          result.success?
        end

        def valid?
          validate.success?
        end

        def validate
          raise "#{self.class.name}::Contract must be defined to validate." unless self.class.const_defined?('Contract')

          Util::Validator.new(
            contract: self.class::Contract,
            data: validation_data
          ).validate
        end

        def validation_data
          serializer = resource.serializer
          serializer.serialize[:objects][serializer.id][:data]
        end

        # Comparison

        def ==(other)
          return false unless self.class == other.class
          return false unless resource == other.resource

          true
        end

        # Type Methods

        TYPES.each do |type|
          define_method "#{type.to_s.downcase}?" do
            false
          end

          define_method "convert_to_#{type.to_s.downcase}" do
            update_klass_name = self.class.name.split('::')[0..-2].append(LedgerSync::Util::StringHelpers.camelcase(type.to_s)).join('::')
            Object.const_get(update_klass_name).new(adaptor: adaptor, resource: resource)
          end
        end

        def merge_into(from:, to:)
          case to
          when String, Integer, Array then from
          else to.merge!(from) { |_key, old_value, new_value| merge_into(from: old_value, to: new_value) } if to && from
          end
        end

        private

        def build
          add_root_operation self
        end

        def operate
          raise NotImplementedError, self.class.name
        end
      end

      TYPES.each do |type|
        klass = Class.new do
          include Operation::Mixin

          define_method("#{type.to_s.downcase}?") do
            true
          end
        end
        Operation.const_set(LedgerSync::Util::StringHelpers.camelcase(type.to_s), klass)
      end

      def self.klass_from(adaptor:, method:, object:)
        adaptor.base_module.const_get(
          LedgerSync::Util::StringHelpers.camelcase(object)
        )::Operations.const_get(
          LedgerSync::Util::StringHelpers.camelcase(method)
        )
      end
    end
  end
end
