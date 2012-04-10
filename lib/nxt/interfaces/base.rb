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
    end
  end
end
