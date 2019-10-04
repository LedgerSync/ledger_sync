require 'spec_helper'

RSpec.describe LedgerSync::Resource do
  LedgerSync.resources.each do |key, resource_klass|
    context "when #{key} resource" do
      context '#name' do
        it { expect { resource_klass.new.name }.not_to raise_error }
      end
    end
  end

  it 'does not permit unknown attributes' do
    expect { LedgerSync::Customer.new(foo: :bar) }.to raise_error(RuntimeError)
  end

  it 'keeps resources separate' do
    customer1 = LedgerSync::Customer.new(email: 'test@example.com')
    customer2 = LedgerSync::Customer.new
    expect(customer1.email).to eq('test@example.com')
    expect(customer2.email).to be_nil

    customer2.email = 'asdf'
    expect(customer1.email).to eq('test@example.com')
    expect(customer2.email).to eq('asdf')
  end

  describe '#assign_attributes' do
    it do
      resource = LedgerSync::Customer.new
      expecT(resource.ledger_id).to be_nil
      expecT(resource.name).to be_nil
      resource.assign_attributes(ledger_id: 'foo', name: 'bar')
      expecT(resource.ledger_id).to eq('foo')
      expecT(resource.name).to eq('name')
    end
  end
end
