RSpec.shared_examples 'webhook payloads' do
  describe '#original_payload' do
    it do
      expect(instance.original_payload).to eq(payload)
    end

    it 'parses JSON string payloads' do
      instance = described_class.new(payload: payload.to_json)
      expect(instance.original_payload).to be_a(String)
      expect(instance.original_payload).to eq(payload.to_json)
    end
  end

  describe '#payload' do
    it { expect(instance.payload).to eq(payload) }

    it 'parses JSON string payloads' do
      instance = described_class.new(payload: payload.to_json)
      expect(instance.original_payload).to be_a(String)
      expect(instance.payload).to be_a(Hash)
      expect(instance.payload).to eq(payload)
    end
  end
end