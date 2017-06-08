require_relative 'models/random_around_center'
require_relative '../models/model_settings'

class ModelSource
  MODELS = [Models::RandomAroundCenter].freeze

  def self.default_model_name
    Models::RandomAroundCenter.name
  end

  def self.prepare(base, target, name = default_model_name)
    model = MODELS.find { |m| m.name == name.to_s }
    settings = ModelSettings.for(name: name, base_currency: base, target_currency: target)
    if settings.nil?
      model.new
    else
      model.new(settings)
    end
  end
end
