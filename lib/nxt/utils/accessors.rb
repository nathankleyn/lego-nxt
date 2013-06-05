module NXT
  module Utils
    module Accessors
      include NXT::Utils::Assertions

      def attr_setter(name, options)
        define_method("#{name}=") do |value|
          assert_type(name, value, options[:is]) if options.include?(:is)
          assert_in(name, value, options[:is_key_in]) if options.include?(:is_key_in)

          instance_variable_set("@#{name}", value)
          self
        end
      end
    end
  end
end
