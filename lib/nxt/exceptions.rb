module NXT
  module Exceptions
    class InvalidDeviceError < TypeError; end
    class SerialPortConnectionError < RuntimeError; end
  end
end
