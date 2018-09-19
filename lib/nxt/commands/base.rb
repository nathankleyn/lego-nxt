module NXT
  module Command
    # The base implementation of all commands, providing low-level details that
    # are consistent across all supported types. These are things such as:
    #
    # * Errors.
    # * Sending and receiving of responses.
    # * Addressing the port safely.
    # * Command types.
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

      def port_as_byte(port)
        PORTS[port]
      end

      def send_and_receive(command_identifier, payload = [], response_required = true)
        send(command_identifier, payload, response_required)
        # We bail unless we need to wait for response.
        return unless response_required
        receive
      end

      def send(command_identifier, payload = [], response_required = true)
        command_identifier |= 0x80 unless response_required

        @interface.send([
          command_type,
          command_identifier,
          port_as_byte(port)
        ] + payload)
      end

      def receive
        response = @interface.receive

        raise 'Not a valid response package.' unless response[0] == 0x02
        raise 'Not a valid response to the command that was sent.' unless response[1] == command_identifier
        raise ERRORS[response[2]] unless response[2].zero?

        response[3..-1]
      end
    end
  end
end
