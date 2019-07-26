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
end
