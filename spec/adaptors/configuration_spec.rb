require 'spec_helper'

RSpec.describe LedgerSync::AdaptorConfiguration do
  LedgerSync.adaptors.each do |key, config|
    context "when #{key} adaptor" do
      context '#name' do
        it { expect(config.name).not_to be_nil }
        it { expect(config.name.strip).not_to eq('') }
      end

      context '#new' do
        it do
          allow(config.adaptor_klass).to receive(:new).with(any_args).once
          config.new
        end
      end

      context '#root_key' do
        it { expect(config.root_key).not_to be_nil }
        it { expect(config.root_key).to be_a(Symbol) }
      end
    end
  end
end
