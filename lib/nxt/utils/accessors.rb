module NXT
  module Utils
    module Accessors
      def attr_setter(name, options)
        define_method("#{name}=") do |value|
          if options.include?(:is)
            raise TypeError.new('Expected value to be a number') unless duration.is_a?(options[:is])
          end

          if options.include?(:is_key_in) && !options[:is_key_in].include?(value)
            raise TypeError.new("Expected value to be one of: :#{options[:is_key_in].keys.join(', :')}")
          end

          instance_variable_set("@#{name}", value)
          self
        end
      end
    end
  end
end
