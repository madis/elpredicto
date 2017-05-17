require 'spec_helper'
require 'pry'

require 'httparty'
class FixerRatesApi
  def self.rates(date:, base:)
    JSON.parse(HTTParty.get("https://api.fixer.io/#{date}", base: base))
  end
end

RSpec.describe FixerRatesApi do
  it 'gets them rates' do
    fixtures_path = File.expand_path('../../fixtures', __FILE__)
    example_response = File.read(fixtures_path + '/fixer-rates-2017-01-01.json')
    endpoint_stub = stub_request(:get, 'https://api.fixer.io/2017-01-01').to_return body: example_response
    rates = described_class.rates date: '2017-01-01', base: 'EUR'

    expect(endpoint_stub).to have_been_requested
    expect(rates).to include 'base' => 'EUR'
    expect(rates['rates']).to include 'AUD' => 1.4596, 'USD' => 1.0541
  end
end
