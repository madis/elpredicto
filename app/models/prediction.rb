class Prediction < Dry::Struct
  attribute :rank, Types::Int
  attribute :rate, Types::Float
  attribute :diff, Types::Float
  attribute :year, Types::Int
  attribute :week, Types::Int
end
