# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Department, qa: true, connection: :quickbooks_online do
  let(:connection) { quickbooks_online_connection }
  let(:attribute_updates) do
    {
      name: "QA UPDATE #{test_run_id}"
    }
  end
  let(:record) { :department }
  let(:resource) { FactoryBot.create(record) }

  it_behaves_like 'a standard quickbooks_online resource'

  # There is a bug with the QBO API that does not accept `ParentRef: { value: nil }`.
  # It 500s, so we have to overwrite the normal reference serialization.
  describe '#parent' do
    it 'removes parent' do
      local_parent = FactoryBot.create(:department, parent: nil)
      expect(local_parent.parent).to be_nil

      result = create_result_for(
        connection: connection,
        resource: local_parent
      ).raise_if_error

      expect(result).to be_success
      parent = result.resource
      expect(parent.parent).to be_nil

      result = create_result_for(
        connection: connection,
        resource: FactoryBot.create(:department, parent: parent)
      ).raise_if_error

      expect(result).to be_success
      child = result.resource

      expect(child.parent).to be_present
      expect(child.parent.ledger_id).to eq(parent.ledger_id)

      child.assign_attributes(parent: nil)
      result = update_result_for(
        connection: connection,
        resource: child
      )

      expect(result).to be_success
      new_child = result.resource

      expect(new_child.ledger_id).to eq(child.ledger_id)
      expect(new_child.parent).not_to be_present

      result = find_result_for(
        connection: connection,
        resource: new_child.class.new(
          ledger_id: new_child.ledger_id
        )
      ).raise_if_error

      expect(result).to be_success
      resource = result.resource

      expect(resource.ledger_id).to eq(child.ledger_id)
      expect(resource.parent).not_to be_present
    end

    it 'does not remove parent' do
      local_parent = FactoryBot.create(:department, parent: nil)
      expect(local_parent.parent).to be_nil

      result = create_result_for(
        connection: connection,
        resource: local_parent
      ).raise_if_error

      expect(result).to be_success
      parent = result.resource
      expect(parent.parent).to be_nil

      result = create_result_for(
        connection: connection,
        resource: FactoryBot.create(:department, parent: parent)
      ).raise_if_error

      expect(result).to be_success
      child = result.resource

      expect(child.parent).to be_present
      expect(child.parent.ledger_id).to eq(parent.ledger_id)

      child.assign_attributes(attribute_updates)
      result = update_result_for(
        connection: connection,
        resource: child
      )

      expect(result).to be_success
      new_child = result.resource

      expect(new_child.ledger_id).to eq(child.ledger_id)
      expect(new_child.parent).to be_present
      expect(new_child.parent.ledger_id).to eq(parent.ledger_id)

      result = find_result_for(
        connection: connection,
        resource: new_child.class.new(
          ledger_id: new_child.ledger_id
        )
      ).raise_if_error

      expect(result).to be_success
      resource = result.resource

      expect(resource.ledger_id).to eq(child.ledger_id)
      expect(resource.parent).to be_present
      expect(new_child.parent.ledger_id).to eq(parent.ledger_id)
    end
  end
end
