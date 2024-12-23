# frozen_string_literal: true

RSpec.shared_examples 'a serializable object' do
  it 'serializes consistently across instances' do
    resource1 = new_resource
    resource2 = new_resource
    expect(resource1).to eq(resource2)
    expect(resource1.simply_serialize[:root]).to eq(resource2.simply_serialize[:root])
  end
end
