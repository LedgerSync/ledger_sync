# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Serializer do
  let(:test_serializer_class) do
    Class.new(LedgerSync::Serializer) do
      attribute :name
      attribute :phone_number
      attribute :email
    end
  end

  let(:custom_serializer_class) do
    Class.new(LedgerSync::Serializer) do
      attribute :foo,
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

  describe '#serialize' do
    context 'type switching' do
      let(:resource) { custom_resource_class.new(foo: 'foo_1') }

      let(:test_serializer) do
        Class.new(LedgerSync::Serialization::SerializerDelegator) do
          private

          def serializer_for(args = {})
            resource = args.fetch(:resource)

            case resource.type
            when 'type_1'
              Class.new(LedgerSync::Serializer) do
                attribute :bar,
                          resource_attribute: :foo
              end
            when 'type_2'
              Class.new(LedgerSync::Serializer) do
                attribute :baz,
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

    it do
      h = {
        'email' => 'test_email',
        'name' => 'test_name',
        'phone_number' => 'test_phone'
      }
      expect(test_serializer.serialize(resource: test_resource)).to eq(h)
    end

    context 'only_changes' do
      it do
        resource = LedgerSync::Customer.new
        serializer = test_serializer_class.new

        expect(serializer.serialize(only_changes: true, resource: resource)).to eq({})
        resource.name = 'Testing'
        expect(serializer.serialize(only_changes: true, resource: resource)).to eq('name' => 'Testing')
      end
    end

    it 'allows multiple values in nested hash' do
      resource = LedgerSync::JournalEntryLineItem.new(
        entry_type: 'debit',
        account: LedgerSync::Account.new(
          ledger_id: 'adsf'
        ),
        ledger_class: LedgerSync::LedgerClass.new(
          ledger_id: 'asdf'
        ),
        department: LedgerSync::Department.new(
          ledger_id: 'asdf'
        )
      )

      serializer_class = Class.new(LedgerSync::Serializer) do
        attribute 'JournalEntryLineDetail.AccountRef.value',
                  resource_attribute: 'account.ledger_id'

        attribute 'JournalEntryLineDetail.ClassRef.value',
                  resource_attribute: 'ledger_class.ledger_id'
      end

      h = {
        'JournalEntryLineDetail' => {
          'AccountRef' => {
            'value' => 'adsf'
          },
          'ClassRef' => {
            'value' => 'asdf'
          }
        }
      }

      expect(serializer_class.new.serialize(resource: resource)).to eq(h)
    end

    context 'with custom attributes' do
      let(:test_resource) { custom_resource_class.new(foo: 'asdf') }
      let(:test_serializer) do
        custom_serializer_class.new
      end

      it do
        h = {
          'foo' => 'asdf'
        }

        expect(test_serializer.serialize(resource: test_resource)).to eq(h)
      end
    end
  end
end
