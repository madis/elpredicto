require 'httparty'

class FixerRatesApi
  def self.rates(date:, base:)
    JSON.parse(HTTParty.get("https://api.fixer.io/#{date}", base: base))
  end
end
