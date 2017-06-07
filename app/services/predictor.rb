require_relative '../models/prediction'

class Predictor
  WEEK = 7 * 24 * 60 * 60

  def initialize(model:)
    @model = model
  end

  def predict(amount:, max_wait:)
    current_rate = rates_with_time(max_wait).first[0]
    sorted_rates = rates_with_time(max_wait).sort_by { |(rate, _time)| rate }
    collect_predictions(sorted_rates, amount, current_rate).sort_by(&:week)
  end

  private

  attr_reader :model

  def collect_predictions(rates, amount, current_rate)
    rates.each_with_index.map do |(rate, time), rank|
      week = time.strftime('%U').to_i
      Prediction.new(
        rank: rank,
        rate: rate,
        diff: amount * (rate - current_rate),
        year: time.year,
        week: week
      )
    end
  end

  def rates_with_time(max_wait)
    start_time = Time.now
    (0...max_wait).map do |w|
      time = start_time + WEEK * w
      rate = model.predict time
      [rate, time]
    end
  end
end
