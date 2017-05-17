#!/usr/bin/env ruby

require 'bundler'
Bundler.setup
require 'httparty'

(1..5).each do |day|
  api_path = "2017-01-%02d" % day
  rates = HTTParty.get("https://api.fixer.io/#{api_path}")
  File.open("spec/fixtures/fixer-rates-#{api_path}.json", 'w') do |f|
    f.write rates.to_s
  end
end
