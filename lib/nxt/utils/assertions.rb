module NXT
  module Utils
    module Assertions
      def assert_in(name, value, values)
        unless values.include?(value)
          raise TypeError.new("Expected #{name} to be one of: :#{values.join(', :')}")
        end
      end
    end
  end
end
