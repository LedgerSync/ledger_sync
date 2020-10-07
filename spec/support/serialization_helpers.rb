# frozen_string_literal: true

# Internal serializer helpers
module SerializationHelpers
  def expect_deserialized_attributes(attributes:, response_hash:, deserializer_class:, resource: nil, values: {})
    resource ||= deserializer_class.inferred_resource_class.new
    serializer = deserializer_class.new
    deserialized_resource = serializer.deserialize(hash: response_hash, resource: resource)
    attributes.each do |attribute|
      expect(resource.public_send(attribute)).to be_nil
      expect(deserialized_resource.public_send(attribute)).to eq(values[attribute] || send(attribute))
    end
    deserialized_resource
  end
end
