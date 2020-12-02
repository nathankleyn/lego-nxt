# frozen_string_literal: true

module NXT
  module Interface
    # The base implementation of all communication interfaces. This is
    # effectively the basic set of abstract methods that an interface needs to
    # define to slot into this framework.
    class Base
      def send
        raise(InterfaceNotImplemented, 'The #send method must be implemented.')
      end

      def receive
        raise(InterfaceNotImplemented, 'The #receive method must be implemented.')
      end
    end
  end
end
