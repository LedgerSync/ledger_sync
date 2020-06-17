# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Ledgers::QuickBooksOnline::Util::ErrorMatcher do
  let(:message) { 'This is the error message.' }
  let(:error) { StandardError.new(message) }

  subject { described_class.new(error: error) }

  it { expect(subject.error).to eq(error) }
  it { expect(subject.message).to eq(message) }
  it { expect(subject.error_message).to eq(message) }
  it { expect(subject.body).to be_nil }
  it { expect(subject.detail).to be_nil }
  it { expect(subject.code).to eq(0) }
  it { expect { subject.error_class }.to raise_error(NotImplementedError) }
  it { expect { subject.match? }.to raise_error(NotImplementedError) }
  it { expect { subject.output_message }.to raise_error(NotImplementedError) }
end
