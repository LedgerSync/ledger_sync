# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Deserializer do
  let(:test_deserializer_class) do
    Class.new(LedgerSync::Deserializer) do
      attribute :name
      attribute :phone_number
      attribute :email
    end
  end

  let(:custom_deserializer_class) do
    Class.new(LedgerSync::Deserializer) do
      attribute :foo,
                hash_attribute: :foo
    end
  end

  let(:test_deserializer) do
    test_deserializer_class.new
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
    it do
      h = {
        'email' => 'test_email',
        'name' => 'test_name',
        'phone_number' => 'test_phone_number'
      }
      dresource = test_deserializer.deserialize(hash: h, resource: test_resource)
      expect(dresource.email).to eq('test_email')
      expect(dresource.name).to eq('test_name')
      expect(dresource.phone_number).to eq('test_phone_number')
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

      deserializer_class = Class.new(LedgerSync::Deserializer) do
        attribute 'account.ledger_id',
                  hash_attribute: 'JournalEntryLineDetail.AccountRef.value'

        attribute 'ledger_class.ledger_id',
                  hash_attribute: 'JournalEntryLineDetail.ClassRef.value'
      end

      h = {
        'JournalEntryLineDetail' => {
          'AccountRef' => {
            'value' => 'adsf1'
          },
          'ClassRef' => {
            'value' => 'asdf2'
          }
        }
      }

      dresource = deserializer_class.new.deserialize(hash: h, resource: resource)
      expect(dresource.account.ledger_id).to eq('adsf1')
      expect(dresource.ledger_class.ledger_id).to eq('asdf2')
    end

    context 'with custom attributes' do
      let(:test_resource) { custom_resource_class.new(foo: 'asdf') }
      let(:test_deserializer) do
        custom_deserializer_class.new
      end

      it do
        h = {
          'foo' => 'asdf'
        }

        dresource = test_deserializer.deserialize(hash: h, resource: test_resource)

        expect(dresource.foo).to eq('asdf')
      end
    end
  end
end
