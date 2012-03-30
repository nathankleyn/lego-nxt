require "serialport"

module NXT
  module Interface
    class SerialPort < Base
      extend NXT::Exceptions

      attr_reader :dev

      BAUD_RATE = 57600
      DATA_BITS = 8
      STOP_BITS = 1
      PARITY = ::SerialPort::NONE
      READ_TIMEOUT = 5000

      def initialize(dev)
        self.dev = (dev)
      end

      def dev=(dev)
        raise InvalidDeviceError unless File.exists?(dev)
        @dev = dev
      end

      def connect
        @connection = ::SerialPort.new(@dev, BAUD_RATE, DATA_BITS, STOP_BITS, PARITY)

        if !@connection.nil?
          @connection.flow_control = ::SerialPort::HARD
          @connection.read_timeout = READ_TIMEOUT
        else
          raise SerialPortConnectionError.new("Could not establish a SerialPort connection to #{dev}")
        end

        @connection
      rescue ArgumentError
        raise SerialPortConnectionError.new("The #{dev} device is not a valid SerialPort")
      end

      def send(msg)
        # The expected data package structure for NXT Bluetooth communication is:
        #
        #     [Length Byte 1, Length Byte 2, Command Type, Command, ...]
        #
        # So here we calculate the two leading length bytes, and rely on the
        # passed in argument to give us the rest of the message to send.
        #
        # Note that the length is stored in Little Endian ie. LSB -> MSB
        #
        # Reference: Appendix 1, Page 22
        msg = [(msg.size & 255), (msg.size >> 8)] + msg
        msg.each do |b|
          @connection.putc(b)
        end
      end

      def receive
        # This gets the length of the received data from the header that was sent
        # to us. We unpack it, as it's stored as a 16-bit Little Endian number.
        #
        # Reference: Appendix 1, Page 22
        length = @connection.sysread(2).unpack("v")[0]
        @connection.sysread(length.unpack("v")[0])
      end

      def close
        @connection.close if @connection && !@connection.closed?
      end

      def connected?
        !@connection.closed?
      end
    end
  end
end
