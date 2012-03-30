require 'rspec/expectations'

RSpec::Matchers.define :have_constant do |expected|
  match do |actual|
    actual.class.constants.include?(expected)
  end
end
