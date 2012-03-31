module NXT
  module Exceptions
    class InvalidInterfaceError < TypeError; end
    class PortTakenError < TypeError; end
    class InvalidIdentifierError < TypeError; end
    class InvalidDeviceError < TypeError; end
    class SerialPortConnectionError < RuntimeError; end
  end
end
