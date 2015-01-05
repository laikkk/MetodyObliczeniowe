require_relative '../lib/Wezel'
require_relative '../lib/Wielomian'
require_relative '../lib/Rownanie'
require_relative '../lib/WczytajDane'

require 'simplecov'
SimpleCov.start
require 'spec_helper.rb'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end
