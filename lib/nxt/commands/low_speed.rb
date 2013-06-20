module NXT
  module Command
    # An implementation of all the low speed I2C related NXT commands:
    #
    # * LSGETSTATUS
    # * LSWRITE
    # * LSREAD
    #
    # This class can also be used to talk to other third-party accessories
    # connected in the input ports on the NXT brick that talk using I2C
    # low speed master/slave communication.
    module LowSpeed
      include NXT::Command::Base
      extend NXT::Utils::Accessors

      COMMAND_IDENTIFIER = {
        ls_get_status: 0x0E,
        ls_write: 0x0F,
        ls_read: 0x10
      }.freeze

      def command_type
        COMMAND_TYPES[:direct]
      end

      def ls_get_status(response_required = false)
        send_and_receive(COMMAND_IDENTIFIER[:ls_get_status])
      end

      def ls_write(response_required = false)
        send_and_receive(COMMAND_IDENTIFIER[:ls_write])
      end

      def ls_read(response_required = false)
        send_and_receive(COMMAND_IDENTIFIER[:ls_read])
      end
    end
  end
end
