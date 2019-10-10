# frozen_string_literal: true

# Internal serializer helpers
module SerializerHelpers
  def expect_deserialized_attributes(attributes:, h:, resource:, serializer_class:)
    serializer = serializer_class.new(resource: resource)
    deserialized_resource = serializer.deserialize(h)
    attributes.each do |attribute|
      expect(resource.public_send(attribute)).to be_nil
      expect(deserialized_resource.public_send(attribute)).to eq(send(attribute))
    end
  end
end
