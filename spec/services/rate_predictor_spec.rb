require_relative '../../app/services/predictor'

RSpec.describe Predictor do
  describe '#predict' do
    let(:exchange_info) { { amount: 17_000, max_wait: 2 } }
    let(:model) { double('supamodel') }
    subject { Predictor.new(model: model).predict exchange_info }

    it 'returns one for each week' do
      allow(model).to receive(:predict).and_return(1, 2)
      expect(subject.count).to eq 2
    end

    it 'returns Predictions' do
      allow(model).to receive(:predict).and_return(1, 2)
      expect(subject).to all(be_a(Prediction))
    end

    it 'returns values ordered by rank' do
      allow(model).to receive(:predict).and_return(1, 2)
      ranks = subject.map(&:rank)
      expect(ranks).to eq [0, 1]
    end
  end
end
