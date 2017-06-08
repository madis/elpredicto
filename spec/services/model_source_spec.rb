require_relative '../../app/services/model_source'

RSpec.describe ModelSource do
  it 'initializes model with existing settings if possible' do
    model_params = { base_rate: 1, range: 1 }
    allow(ModelSettings).to receive(:for).with(
      name: 'Models::RandomAroundCenter',
      base_currency: 'EUR',
      target_currency: 'USD'
    ).and_return model_params
    model = described_class.prepare('EUR', 'USD')
    expect(model).to be_a Models::RandomAroundCenter
    expect(model.predict(Time.now)).to be_within(1).of(1)
  end

  context 'no settings present' do
    it 'trains new model'
    it 'stores settings for future use'
  end
end
