# frozen_string_literal: true

require 'spec_helper'

support :ledger_serializer_helpers

RSpec.describe LedgerSync::Serializer do
  include LedgerSerializerHelpers

  let(:test_serializer_class) do
    Class.new(LedgerSync::Serializer) do
      attribute output_attribute: :name,
                resource_attribute: :name
      attribute output_attribute: :phone_number,
                resource_attribute: :phone_number
      attribute output_attribute: :email,
                resource_attribute: :email
    end
  end

  let(:custom_serializer_class) do
    Class.new(LedgerSync::Serializer) do
      attribute output_attribute: :foo,
                resource_attribute: :foo
    end
  end

  let(:test_serializer) do
    test_serializer_class.new
  end

  let(:test_resource) do
    LedgerSync::Customer.new(
      name: 'test_name',
      phone_number: 'test_phone',
      email: 'test_email'
    )
  end

  let(:custom_resource_class) do
    class_name = "#{test_run_id}TestCustomResource1"
    Object.const_get(class_name)
  rescue NameError
    Object.const_set(
      class_name,
      Class.new(LedgerSync::Customer) do
        attribute :foo, type: LedgerSync::Type::String
        attribute :type, type: LedgerSync::Type::String
      end
    )
  end

  it { expect(described_class).to respond_to(:attribute) }
  it { expect(described_class).to respond_to(:references_many) }
  it { expect(described_class).to respond_to(:references_one) }
  it { expect(described_class).to respond_to(:id) }

  describe '#serialize' do
    context 'type switching' do
      let(:resource) { custom_resource_class.new(foo: 'foo_1') }

      let(:test_serializer) do
        Class.new(LedgerSync::Serializer::Delegator) do
          private

          def serializer_for(args = {})
            resource = args.fetch(:resource)

            case resource.type
            when 'type_1'
              Class.new(LedgerSync::Serializer) do
                attribute output_attribute: :bar,
                          resource_attribute: :foo
              end
            when 'type_2'
              Class.new(LedgerSync::Serializer) do
                attribute output_attribute: :baz,
                          resource_attribute: :foo
              end
            end
          end
        end
      end

      it do
        resource.type = 'type_1'
        h = {
          'bar' => 'foo_1'
        }
        expect(test_serializer.new.serialize(resource: resource)).to eq(h)
      end

      it do
        resource.type = 'type_2'
        h = {
          'baz' => 'foo_1'
        }
        expect(test_serializer.new.serialize(resource: resource)).to eq(h)
      end
    end

    # it do
    #   h = {
    #     'phone_number' => 'test_phone',
    #     'email' => 'test_email'
    #   }
    #   expect(test_serializer.serialize).to eq(h)
    # end

    # it do
    #   resource = LedgerSync::Customer.new
    #   serializer = LedgerSync::Adaptors::QuickBooksOnline::Customer::LedgerSerializer.new(resource: resource)

    #   expect(serializer.to_ledger_hash(only_changes: true)).to eq({})
    #   resource.name = 'Testing'
    #   expect(serializer.to_ledger_hash(only_changes: true)).to eq('DisplayName' => 'Testing')
    # end

    # it 'allows multiple values in nested hash' do
    #   resource = LedgerSync::JournalEntryLineItem.new(
    #     entry_type: 'debit',
    #     account: LedgerSync::Account.new(
    #       ledger_id: 'adsf'
    #     ),
    #     ledger_class: LedgerSync::LedgerClass.new(
    #       ledger_id: 'asdf'
    #     ),
    #     department: LedgerSync::Department.new(
    #       ledger_id: 'asdf'
    #     )
    #   )
    #   serializer = LedgerSync::Adaptors::QuickBooksOnline::JournalEntryLineItem::LedgerSerializer.new(resource: resource)

    #   h = {
    #     'Amount' => nil,
    #     'Description' => nil,
    #     'DetailType' => 'JournalEntryLineDetail',
    #     'JournalEntryLineDetail' => {
    #       'PostingType' => 'Debit',
    #       'AccountRef' => {
    #         'value' => 'adsf'
    #       },
    #       'ClassRef' => {
    #         'value' => 'asdf'
    #       },
    #       'DepartmentRef' => {
    #         'value' => 'asdf'
    #       }
    #     }
    #   }

    #   expect(serializer.to_ledger_hash).to eq(h)
    # end

    # context 'with custom attributes' do
    #   let(:test_resource) { custom_resource_class.new(foo: 'asdf') }
    #   let(:test_serializer) do
    #     custom_serializer_class.new(
    #       resource: test_resource
    #     )
    #   end

    #   it do
    #     h = {
    #       'foo' => 'asdf'
    #     }

    #     expect(test_serializer.to_ledger_hash).to eq(h)
    #   end
    # end
  end
end
