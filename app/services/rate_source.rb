require_relative 'fixer_rates_api'
require_relative '../models/exchange_rate'

class RateSource
  def initialize(api:, store:)
    @api = api
    @store = store
  end

  def fetch(base:, target:, weeks:)
    Array.new(weeks) do |week|
      date = (Time.now - week.weeks).beginning_of_day
      rate_from_store(base, target, date) || rate_from_api(base, target, date)
    end
  end

  private

  attr_reader :store, :api

  def format_date_for_api(date)
    date.strftime('%Y-%m-%d')
  end

  def rate_from_store(base, target, date)
    store.find base: base, target: target, date: date
  end

  def update_rates(rates)
    base = rates['base']
    date = rates['date']
    rates['rates'].each do |rate|
      store.create_or_update base: base, target: rate, date: date
    end
  end

  def rate_from_api(base, target, date)
    rates = api.rates date: format_date_for_api(date), base: base
    update_rates(rates)
    rate = rates['rates'][target]
    ExchangeRate.new base: base, target: target, rate: rate, date: date
  end
end
