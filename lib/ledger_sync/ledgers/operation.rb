# frozen_string_literal: true

module LedgerSync
  module Ledgers
    module Operation
      module Mixin # rubocop:disable Metrics/ModuleLength
        module ClassMethods
          def client_class
            @client_class ||= Class.const_get("#{name.split('::')[0..2].join('::')}::Ledger")
          end

          def inherited(base)
            base.inferred_resource_class.operations[base.operation_method] = base

            super
          end

          def operation_method
            @operation_method ||= name.split('::').last.underscore.to_sym
          end

          def operations_module
            @operations_module ||= Object.const_get("#{name.split('::Operations::').first}::Operations")
          end
        end

        def self.included(base)
          base.include SimplySerializable::Mixin
          base.include Fingerprintable::Mixin
          base.include Error::HelpersMixin
          base.include Ledgers::Mixins::InferSerializerMixin
          base.include Ledgers::Mixins::SerializationMixin
          base.include Ledgers::Mixins::InferValidationContractMixin
          base.extend ClassMethods

          base.class_eval do
            simply_serialize only: %i[
              client
              resource
              result
              response
            ]
          end
        end

        attr_reader :client,
                    :resource,
                    :resource_before_perform,
                    :result,
                    :response

        def initialize(args = {})
          @client = args.fetch(:client)
          @deserializer = args.fetch(:deserializer, nil)
          @resource = args.fetch(:resource)
          @serializer = args.fetch(:serializer, nil)
          @resource_before_perform = resource.dup
          @result = nil
          @validation_contract = args.fetch(:validation_contract, nil)

          # self.class.raise_if_unexpected_class(expected: self.class.inferred_resource_class, given: @resource.class)
          return if @validation_contract.nil?

          self.class.raise_if_unexpected_class(expected: LedgerSync::Ledgers::Contract, given: validation_contract)
        end

        def perform
          failure(LedgerSync::Error::OperationError::PerformedOperationError.new(operation: self)) if @performed

          @result = begin
            operate
          rescue LedgerSync::Error => e
            failure(e)
          rescue StandardError => e
            parsed_error = client.parse_operation_error(error: e, operation: self)
            raise e unless parsed_error

            failure(parsed_error)
          ensure
            @performed = true
          end
        end

        def performed?
          @performed == true
        end

        def deserializer
          @deserializer ||= deserializer_class.new
        end

        def deserializer_class
          @deserializer_class ||= self.class.inferred_deserializer_class
        end

        def serializer
          @serializer ||= deserializer_class.new
        end

        def serializer_class
          @serializer_class ||= self.class.inferred_serializer_class
        end

        # Results

        def failure(error, resource: nil, response: nil)
          @result = LedgerSync::OperationResult.Failure(
            error,
            operation: self,
            resource: resource,
            response: response
          )
        end

        def failure?
          result.failure?
        end

        def success(resource:, response:)
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
          simply_serializer_instance = resource.simply_serializer(
            do_not_serialize_if_class_is: Resource::PRIMITIVES
          )
          simply_serializer_instance.serialize[:objects][simply_serializer_instance.id][:data]
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

      def self.class_from(client:, method:, object:)
        client.base_module.const_get(
          LedgerSync::Util::StringHelpers.camelcase(object)
        )::Operations.const_get(
          LedgerSync::Util::StringHelpers.camelcase(method)
        )
      end
    end
  end
end
