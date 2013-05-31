module NXT
  module Interface
    class Base
      def send_and_receive(msg, response_required = true)
        unless response_required
          msg[0] = msg[0] | 0x80
        end

        self.send(msg)

        if response_required
          response = self.receive
          binding.pry
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
