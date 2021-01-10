# frozen_string_literal: true

module LedgerSync
  module ResultBase
    module HelperMethods
      def Success(value = nil, **args) # rubocop:disable Naming/MethodName
        self::Success.new(value, **args)
      end

      def Failure(error = nil, **args) # rubocop:disable Naming/MethodName
        self::Failure.new(error, **args)
      end
    end

    def self.included(base)
      base.const_set('Success', Class.new(Resonad::Success))
      base::Success.include base::ResultTypeBase if base.const_defined?('ResultTypeBase')

      base.const_set('Failure', Class.new(Resonad::Failure))
      base::Failure.include base::ResultTypeBase if base.const_defined?('ResultTypeBase')

      base.extend HelperMethods
    end
  end

  class Result
    include ResultBase
  end

  class OperationResult
    module ResultTypeBase
      attr_reader :operation, :resource, :response

      def self.included(base)
        base.class_eval do
          simply_serialize only: %i[operation resource response]
        end
      end

      def initialize(*args, operation:, resource:, response:)
        @operation = operation
        @resource = resource
        @response = response
        super(*args)
      end
    end

    include ResultBase
  end

  class SearchResult
    module ResultTypeBase
      attr_reader :resources, :searcher

      def self.included(base)
        base.class_eval do
          # TODO: removed next and previous searcher, because it causes a string of them.
          # We should add next_searcher_params which would be easier to serialize.
          simply_serialize only: %i[
            resources
            searcher
          ]
        end
      end

      def initialize(*args, searcher:, **keywords)
        @resources = searcher.resources
        @searcher = searcher
        super(*args, **keywords)
      end

      def next_searcher
        searcher.next_searcher
      end

      def next_searcher?
        !next_searcher.nil?
      end

      def previous_searcher
        searcher.previous_searcher
      end

      def previous_searcher?
        !previous_searcher.nil?
      end
    end

    include ResultBase
  end

  class ValidationResult
    module ResultTypeBase
      attr_reader :validator

      def self.included(base)
        base.class_eval do
          simply_serialize only: %i[validator]
        end
      end

      def initialize(validator)
        raise 'The argument must be a validator' unless validator.is_a?(Util::Validator)

        @validator = validator
        super(validator)
      end
    end

    include ResultBase
  end
end
