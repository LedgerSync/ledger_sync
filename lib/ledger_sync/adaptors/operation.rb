# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module Operation
      TYPES = %i[create delete find update].freeze

      module Mixin
        module ClassMethods
          def adaptor_klass
            @adaptor_klass ||= Class.const_get("#{name.split('::')[0..2].join('::')}::Adaptor")
          end

          def operations_module
            @operations_module ||= Object.const_get(name.split('::Operations::').first + '::Operations')
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
          base.include Error::HelpersMixin
          base.include Adaptors::Mixins::InferLedgerSerializerMixin
          base.include Adaptors::Mixins::InferValidationContractMixin
          base.extend ClassMethods

          base.class_eval do
            serialize only: %i[
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
                    :resource_before_perform,
                    :root_operation,
                    :result,
                    :response,
                    :original

        def initialize(
          adaptor:,
          ledger_deserializer_class: nil,
          ledger_serializer_class: nil,
          resource:,
          validation_contract: nil
        )
          self.class.raise_if_unexpected_class(expected: self.class.resource_klass, given: resource.class)

          @adaptor = adaptor
          @after_operations = []
          @before_operations = []
          @ledger_deserializer_class = ledger_deserializer_class
          @ledger_serializer_class = ledger_serializer_class
          @operations = []
          @resource = resource
          @resource_before_perform = resource.dup
          @result = nil
          @root_operation = nil
          @validation_contract = validation_contract

          self.class.raise_if_unexpected_class(expected: LedgerSync::Adaptors::Contract, given: send(:validation_contract))
          self.class.raise_if_unexpected_class(expected: LedgerSync::Adaptors::LedgerSerializer, given: send(:ledger_deserializer_class))
          self.class.raise_if_unexpected_class(expected: LedgerSync::Adaptors::LedgerSerializer, given: send(:ledger_serializer_class))
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

        def ledger_deserializer
          ledger_deserializer_class.new(resource: resource)
        end

        def ledger_deserializer_class
          @ledger_deserializer_class ||= self.class.inferred_ledger_deserializer_class
        end

        def ledger_serializer
          ledger_serializer_class.new(resource: resource)
        end

        def ledger_serializer_class
          @ledger_serializer_class ||= self.class.inferred_ledger_serializer_class
        end

        # Results

        def failure(error, resource: nil)
          @response = error
          @result = LedgerSync::OperationResult.Failure(
            error,
            operation: self,
            resource: resource,
            response: error
          )
        end

        def failure?
          result.failure?
        end

        def success(resource:, response:)
          @response = response
          @result = LedgerSync::OperationResult.Success(
            self,
            operation: self,
            resource: resource,
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
          Util::Validator.new(
            contract: validation_contract,
            data: validation_data
          ).validate
        end

        def validation_contract
          @validation_contract ||= self.class.inferred_validation_contract_class
        end

        def validation_data
          serializer = resource.serializer(
            do_not_serialize_if_class_is: Resource::PRIMITIVES
          )
          serializer.serialize[:objects][serializer.id][:data]
        end

        def errors
          validate.validator.errors
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
        end

        private

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
