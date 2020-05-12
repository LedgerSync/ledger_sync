# frozen_string_literal: true

# RSpec.shared_examples 'a quickbooks_online create' do
#   it do
#     result = create_result_for(
#       connection: connection,
#       resource: resource
#     )

#     expect(result).to be_success
#   end
# end

# RSpec.shared_examples 'a quickbooks_online find' do
#   it do
#     result = create_result_for(
#       connection: connection,
#       resource: resource
#     ).raise_if_error
#     expect(result).to be_success
#     resource = result.resource

#     result = find_result_for(
#       connection: connection,
#       resource: resource
#     )

#     expect(result).to be_success
#   end
# end

# RSpec.shared_examples 'a quickbooks_online update' do
#   it do
#     result = create_result_for(
#       connection: connection,
#       resource: resource
#     ).raise_if_error

#     expect(result).to be_success
#     resource = result.resource

#     # Ensure values are currently not the same as the updates
#     attribute_updates.each do |k, v|
#       expect(resource.send(k)).not_to eq(v)
#     end

#     resource.assign_attributes(attribute_updates)
#     result = update_result_for(
#       connection: connection,
#       resource: resource
#     )

#     expect(result).to be_success
#     resource = result.resource

#     # Ensure values are updated
#     attribute_updates.each do |k, v|
#       expect(resource.send(k)).to eq(v)
#     end

#     result = find_result_for(
#       connection: connection,
#       resource: resource.class.new(
#         ledger_id: resource.ledger_id
#       )
#     ).raise_if_error

#     expect(result).to be_success
#     resource = result.resource

#     # Ensure values are updated after raw find
#     attribute_updates.each do |k, v|
#       expect(resource.send(k)).to eq(v)
#     end
#   end
# end

RSpec.shared_examples 'a standard quickbooks_online resource' do
  it_behaves_like 'a create', delete: false
  it_behaves_like 'a find', delete: false
  it_behaves_like 'an update', delete: false
end

RSpec.shared_examples 'a find only quickbooks_online resource' do
  it_behaves_like 'a find only', delete: false
end
