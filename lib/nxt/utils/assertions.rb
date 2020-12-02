# frozen_string_literal: true

module NXT
  module Utils
    # Utilities related to asserting values are what is expected.
    module Assertions
      def assert_in(name, value, values)
        raise(TypeError, "Expected #{name} to be one of: :#{values.join(', :')}") unless values.include?(value)
      end

      def assert_type(name, value, type)
        raise(TypeError, "Expected #{name} to be of type #{type}") unless value.is_a?(type)
      end

      def assert_responds_to(name, value, *methods)
        valid = methods.all? do |method|
          value.respond_to?(method)
        end

        raise(TypeError, "Expected #{name} to respond to: #{methods.join(', ')}") unless valid
      end
    end
  end
end
