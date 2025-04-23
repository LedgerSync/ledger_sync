# Usage: bundle exec rspec spec/deserializer/acceptance_artifact_spec.rb

require 'ledger_sync'
require 'rspec'

class Package < LedgerSync::Resource
  attribute :blabla, type: LedgerSync::Type::String
end

class Package
  class Deserializer < LedgerSync::Deserializer
    attribute :blabla, hash_attribute: :blabla
  end
end

class AcceptanceArtifact < LedgerSync::Resource
  attribute :identifier, type: LedgerSync::Type::String
  references_many :packages, to: Package
end

class AcceptanceArtifact
  class Deserializer < LedgerSync::Deserializer
    attribute :identifier, hash_attribute: :identifier
    references_many :packages, deserializer: Package::Deserializer,  hash_attribute: :packages
  end
end

RSpec.describe AcceptanceArtifact::Deserializer do
  describe '#deserialize' do
    let(:deserializer) { described_class.new }
    let(:acceptance_artifact) { AcceptanceArtifact.new }

    subject(:deserialized_object) { deserializer.deserialize(hash: response, resource: acceptance_artifact) }

    context "with empty `packages` in the API's response" do
      let(:response) { { "identifier" => "42", "packages" => [] } }

      it 'deserializes the identifier correctly' do
        expect(deserialized_object.identifier).to eq("42")
      end
    end

    context "with filled `packages` in the API's response" do
      let(:response) { { "identifier" => "42", "packages" => [ { "blabla" => "ok" } ] } }

      it 'deserializes the identifier correctly' do
        expect(deserialized_object.identifier).to eq("42")
      end
    end

    context "without `packages` in the API's response" do
      let(:response) { { "identifier" => "42" } }

      it 'deserializes the packages correctly' do
        expect(deserialized_object.packages).to eq([])
      end
    end
  end
end

# Manual trigger
# deserializer = AcceptanceArtifact::Deserializer.new
# response_1 = { "identifier" => "42", "packages" => [] }
# response_2 = { "identifier" => "42" }
# accept_art = deserializer.deserialize(hash: response_1, resource: AcceptanceArtifact.new)
