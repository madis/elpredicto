class ConversionForm < Dry::Struct::Value
  attribute :amount, Types::Coercible::Float
  attribute :base_currency, Types::String
  attribute :target_currency, Types::String
  attribute :max_wait, Types::Coercible::Int

  CURRENCIES = %w[
    AUD BGN BRL CAD CHF CNY CZK DKK EUR GBP HKD HRK HUF IDR ILS INR
    JPY KRW MXN MYR NOK NZD PHP PLN RON RUB SEK SGD THB TRY USD ZAR
  ].freeze

  WAIT_TIMES = (1..25).to_a.freeze

  VALIDATION = Dry::Validation.Form do
    configure { config.type_specs = true }

    required(:amount, :float).filled(:float?)
    required(:max_wait, :int).filled(:int?)
    required(:base_currency, :string).filled(:str?)
    required(:target_currency, :string).filled(:str?)
  end
end
