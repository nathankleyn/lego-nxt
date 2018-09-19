module NXT
  module Exceptions
    # Raised when a class has not implemented a method from the base class
    # that is required to be overriden.
    class InterfaceNotImplemented < RuntimeError; end

    # Raised when an invalid interface is attempted to be constructed.
    class InvalidInterfaceError < TypeError; end

    # Raised when a port is attempted to be named when it already has been.
    class PortTakenError < TypeError; end

    # Raised when an invalid name is attempted to be given to a port.
    class InvalidIdentifierError < TypeError; end

    # Raised when the device file attempted to be used for communication is
    # for whatever reason does not exist or is not correct.
    class InvalidDeviceError < TypeError; end

    # Raised when communication with a Serial Port connection fails.
    class SerialPortConnectionError < RuntimeError; end

    # Raised when communication with a USB Port connection fails.
    class UsbConnectionError < RuntimeError; end
  end
end
