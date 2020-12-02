# frozen_string_literal: true

if ENV['CI']
  require 'simplecov'
  SimpleCov.start
end

require 'matchers'
require 'lego_nxt'

# rubocop:disable Style/MixinUsage
include NXT::Exceptions
# rubocop:enable Style/MixinUsage
