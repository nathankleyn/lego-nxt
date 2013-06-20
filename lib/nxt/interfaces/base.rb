module NXT
  module Interface
    class Base
      def send
        raise InterfaceNotImplemented.new('The #send method must be implemented.')
      end

      def receive
        raise InterfaceNotImplemented.new('The #receive method must be implemented.')
      end
    end
  end
end
