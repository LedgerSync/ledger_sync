# frozen_string_literal: true

# Internal serializer helpers
module SerializationHelpers
  def expect_deserialized_attributes(attributes:, response_hash:, resource: nil, serializer_class:, values: {})
    resource ||= serializer_class._inferred_resource_class.new
    serializer = serializer_class.new(resource: resource)
    deserialized_resource = serializer.deserialize(response_hash)
    attributes.each do |attribute|
      expect(resource.public_send(attribute)).to be_nil
      expect(deserialized_resource.public_send(attribute)).to eq(values[attribute] || send(attribute))
    end
    deserialized_resource
  end
end
