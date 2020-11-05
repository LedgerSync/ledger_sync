# frozen_string_literal: true

require 'spec_helper'

module LedgerSync
  module Test
    class ValidateInferSerializer
      include LedgerSync::Ledgers::Mixins::InferSerializerMixin

      def self.inferred_resource_class
        'LedgerSync::Test::MyResource'
      end
    end
  end
end

RSpec.describe LedgerSync::Ledgers::Mixins::InferSerializerMixin do
  subject { LedgerSync::Test::ValidateInferSerializer }
  let(:name) { 'LedgerSync::Test::MyResource' }

  it do
    expect(subject.inferred_deserializer_class_name).to eq(
      'LedgerSync::Test::MyResource::Deserializer'
    )
    expect(subject.inferred_searcher_deserializer_class_name).to eq(
      'LedgerSync::Test::MyResource::SearcherDeserializer'
    )
    expect(subject.inferred_serializer_class_name).to eq(
      'LedgerSync::Test::MyResource::Serializer'
    )
  end
end
