require_relative '../../app/services/rate_source'
require 'active_support'
require 'active_support/core_ext'

RSpec.describe RateSource do
  it 'fetches from api when needed' do
    fixer_api = object_double(FixerRatesApi)
    allow(fixer_api).to receive(:rates).and_return hash_fixture('fixer-rates-2017-01-01.json')
    store = double('store')
    allow(store).to receive(:find).and_return nil
    allow(store).to receive(:create_or_update)
    source = described_class.new(api: fixer_api, store: store)
    result = source.fetch base: 'EUR', target: 'USD', weeks: 3
    expect(result).to all(be_an(ExchangeRate))
    expect(result.first.rate).to eq 1.0541
  end

  it 'gets from when possible' do
    fixer_api = object_double(FixerRatesApi)
    store = double('store')
    example_rate = ExchangeRate.new(base: 'EUR', target: 'USD', rate: 1.5, date: Time.now)
    allow(store).to receive(:find).and_return example_rate
    allow(store).to receive(:create_or_update)
    source = described_class.new(api: fixer_api, store: store)
    result = source.fetch base: 'EUR', target: 'USD', weeks: 1
    expect(result).to eq [example_rate]
  end
end
