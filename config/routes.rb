Rails.application.routes.draw do
  root to: 'conversions#new'
  get 'conversions', to: 'conversions#new'
end
