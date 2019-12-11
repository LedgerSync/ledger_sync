# frozen_string_literal: true

require 'spec_helper'

RSpec.describe LedgerSync::Util::Signer do
  let(:key) { 'secret' }
  let(:str) { 'Message' }

  let(:signer) { described_class.new(str: str) }

  describe '#hmac_sha1' do
    context 'https://ruby-doc.org/stdlib-2.4.0/libdoc/openssl/rdoc/OpenSSL/HMAC.html#method-c-digest' do
      let(:key) { 'key' }
      let(:str) { 'The quick brown fox jumps over the lazy dog'}
      let(:signature) { signer.hmac_sha1(escape: false, key: key) }

      it { expect(signature).to eq('3nybhbi3iqa8ino29wqQcBydtNk=') }
    end
  end

  describe '#hmac_sha256' do
    let(:signature) { signer.hmac_sha256(key: key) }

    # ref: https://www.jokecamp.com/blog/examples-of-creating-base64-hashes-using-hmac-sha256-in-different-languages/
    it { expect(signature).to eq('qnR8UCqJggD55PohusaBNviGoOJ67HC6Btry4qXLVZc=') }
  end
end
