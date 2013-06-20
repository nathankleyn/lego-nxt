require 'libusb'

module NXT
  module Interface
    class Usb < Base
      include NXT::Exceptions

      ID_VENDOR_LEGO = 0x0694
      ID_PRODUCT_NXT = 0x0002
      OUT_ENDPOINT = 0x01
      IN_ENDPOINT = 0x82
      TIMEOUT = 10000
      READSIZE = 64
      INTERFACE = 0

      def connect
        @usb_context = LIBUSB::Context.new
        @dev = @usb_context.devices(idVendor: ID_VENDOR_LEGO, idProduct: ID_PRODUCT_NXT).first

        if @dev.nil?
          raise UsbConnectionError.new("Could not find NXT attached as USB device")
        end

        @connection = @dev.open
        @connection.claim_interface(INTERFACE)

        @connection
      end

      def disconnect
        if self.connected?
          @connection.release_interface(INTERFACE)
          @connection.close
        end
      end

      def connected?
        # FIXME: How do we check if the device is connected?
        @connection
      end

      def send(msg)
        @connection.bulk_transfer(endpoint: OUT_ENDPOINT, dataOut: msg.pack('C*'), timeout: TIMEOUT)
      end

      def receive
        @connection.bulk_transfer(endpoint: IN_ENDPOINT, dataIn: READSIZE, timeout: TIMEOUT).from_hex_str
      end
    end
  end
end
