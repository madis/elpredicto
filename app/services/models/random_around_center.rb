module Models
  class RandomAroundCenter
    def initialize(base_rate = 1, range = base_rate / 2.0)
      @base_rate = base_rate
      @range = range
    end

    def predict(_time)
      half_range = @range / 2.0
      rand((@base_rate - half_range)..(@base_rate + half_range))
    end
  end
end
