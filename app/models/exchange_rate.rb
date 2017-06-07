class ExchangeRate < Dry::Struct
  attribute :base, Types::String
  attribute :target, Types::String
  attribute :rate, Types::Float
  attribute :date, Types::Date
end
