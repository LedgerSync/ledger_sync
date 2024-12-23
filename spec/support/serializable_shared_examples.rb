# frozen_string_literal: true

RSpec.shared_examples 'a serializable object' do
  it 'serializes consistently across instances' do
    resource_one = new_resource
    resource_two = new_resource
    expect(resource_one).to eq(resource_two)
    expect(resource_one.simply_serialize[:root]).to eq(resource_two.simply_serialize[:root])
  end
end
