# frozen_string_literal: true

module LedgerSync
  module Util
    class Signer
      HMAC_SHA1_DIGEST   = OpenSSL::Digest.new('sha1')
      HMAC_SHA256_DIGEST = OpenSSL::Digest.new('sha256')

      attr_reader :str

      def initialize(str:)
        @str = str
      end

      def hmac_sha1(key:, escape: false)
        ret = Base64.encode64(OpenSSL::HMAC.digest(HMAC_SHA1_DIGEST, key, str)).strip
        ret = self.class.escape(str: ret) if escape
        ret
      end

      def hmac_sha256(key:, escape: false)
        ret = Base64.encode64(OpenSSL::HMAC.digest(HMAC_SHA256_DIGEST, key, str)).strip
        ret = self.class.escape(str: ret) if escape
        ret
      end

      def self.escape(str:)
        CGI.escape(str).gsub(/\+/, '%20')
      end

      def self.unescape(str:)
        CGI.unescape(str.gsub(/%20/, '+'))
      end
    end
  end
end
