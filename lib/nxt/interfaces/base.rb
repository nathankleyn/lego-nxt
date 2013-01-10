module NXT
  module Interface
    class Base
      def send_and_receive(msg, response_required = true)
        if response_required
          msg[0] = msg[0] | (response_required ? 0x80 : 0x00)
        end

        self.send(msg)

        if response_required
          response = self.receive
          response
        end
      end

      def send
        raise InterfaceNotImplemented.new('The #send method must be implemented.')
      end

      def receive
        raise InterfaceNotImplemented.new('The #receive method must be implemented.')
      end
    end
  end
end
