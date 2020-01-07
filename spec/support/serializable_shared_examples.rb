# frozen_string_literal: true

RSpec.shared_examples 'a serializable object' do
  it do
    resource_1 = new_resource
    resource_2 = new_resource
    expect(resource_1).to eq(resource_2)
    expect(resource_1.serialize[:root]).to eq(resource_2.serialize[:root])
  end
end