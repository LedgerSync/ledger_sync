module LedgerSync
  class ResourceError < Error
    attr_reader :resource

    def initialize(message:, resource:)
      @resource = resource
      super(message: message)
    end

    class MissingResourceError < self
      attr_reader :resource_type, :resource_external_id

      def initialize(message:, resource_type:, resource_external_id:)
        @resource_type = resource_type
        @resource_external_id = resource_external_id
        super(message: message, resource: nil)
      end
    end
  end
end
