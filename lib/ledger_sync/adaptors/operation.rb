# frozen_string_literal: true

module LedgerSync
  module Adaptors
    module Operation
      module Mixin
        module ClassMethods
          def adaptor_class
            @adaptor_class ||= Class.const_get("#{name.split('::')[0..2].join('::')}::Adaptor")
          end

          def operation_method
            @operation_method ||= name.split('::').last.snakecase.to_sym
          end

          def operations_module
            @operations_module ||= Object.const_get(name.split('::Operations::').first + '::Operations')
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
              resource
              result
              response
            ]
          end
        end

        attr_reader :adaptor,
                    :resource,
                    :resource_before_perform,
                    :result,
                    :response

        def initialize(
          **keywords
        )
          @adaptor = keywords.fetch(:adaptor)
          @ledger_deserializer_class = keywords.fetch(:ledger_deserializer_class, nil)
          @ledger_serializer_class = keywords.fetch(:ledger_serializer_class, nil)
          @resource = keywords.fetch(:resource)
          @resource_before_perform = resource.dup
          @result = nil
          @validation_contract = keywords.fetch(:validation_contract, nil)

          self.class.raise_if_unexpected_class(expected: self.class.inferred_resource_class, given: @resource.class)
          self.class.raise_if_unexpected_class(expected: LedgerSync::Adaptors::LedgerSerializer, given: ledger_deserializer_class) unless @ledger_deserializer_class.nil?
          self.class.raise_if_unexpected_class(expected: LedgerSync::Adaptors::LedgerSerializer, given: ledger_serializer_class) unless @ledger_serializer_class.nil?
          self.class.raise_if_unexpected_class(expected: LedgerSync::Adaptors::Contract, given: validation_contract) unless @validation_contract.nil?
        end

        def perform
          failure(LedgerSync::Error::OperationError::PerformedOperationError.new(operation: self)) if @performed

          @result = begin
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

        private

        def operate
          raise NotImplementedError, self.class.name
        end
      end

      def self.class_from(adaptor:, method:, object:)
        adaptor.base_module.const_get(
          LedgerSync::Util::StringHelpers.camelcase(object)
        )::Operations.const_get(
          LedgerSync::Util::StringHelpers.camelcase(method)
        )
      end
    end
  end
end
