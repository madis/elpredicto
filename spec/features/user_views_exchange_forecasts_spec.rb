require 'rails_helper'

RSpec.feature 'User views exchange forecasts' do
  scenario 'known currency' do
    visit '/'
    select 'USD', from: 'Base currency'
    select 'EUR', from: 'Target currency'
    fill_in 'Amount', with: 1000
    select 3, from: 'Max wait time'
    click_on 'Calculate'

    rows = page.all 'tr.prediction'
    expect(rows.count).to eq 3
  end
end
