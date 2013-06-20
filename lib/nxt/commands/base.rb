module NXT
  module Command
    module Base
      private

      COMMAND_TYPES = {
        direct: 0x00,
        system: 0x01,
        reply: 0x02
      }.freeze

      PORTS = {
        a: 0x00,
        b: 0x01,
        c: 0x02,
        one: 0x00,
        two: 0x01,
        three: 0x02,
        four: 0x03,
        all: 0xFF
      }.freeze

      ERRORS = {
        'Pending communication transaction in progress' => 0x20,
        'Specified mailbox queue is empty' => 0x40,
        'Request failed (i.e. specified file not found)' => 0xBD,
        'Unknown command opcode' => 0xBE,
        'Insane packet' => 0xBF,
        'Data contains out-of-range values' => 0xC0,
        'Communication bus error' => 0xDD,
        'No free memory in communication buffer' => 0xDE,
        'Specified channel/connection is not valid' => 0xDF,
        'Specified channel/connection not configured or busy' => 0xE0,
        'No active program' => 0xEC,
        'Illegal size specified' => 0xED,
        'Illegal mailbox queue ID specified' => 0xEE,
        'Attempted to access invalid field of a structure' => 0xEF,
        'Bad input or output specified' => 0xF0,
        'Insufficient memory available' => 0xFB,
        'Bad arguments' => 0xFF
      }.invert.freeze

      def send_and_receive(command_identifier, payload = [], response_required = true)
        unless response_required
          command_identifier |= 0x80
        end

        @interface.send([
          command_type,
          command_identifier,
          port_as_byte(self.port)
        ] + payload)

        if response_required
          response = @interface.receive

          puts response.inspect
          puts command_identifier.inspect

          raise 'Not a valid response package.' unless response[0] == 0x02
          raise 'Not a valid response to the command that was sent.' unless response[1] == command_identifier
          raise ERRORS[response[2]] unless response[2] == 0x00

          response[3..-1]
        end
      end

      def port_as_byte(port)
        PORTS[port]
      end
    end
  end
end
