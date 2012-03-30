$:.unshift(File.dirname(__FILE__))

require "active_support/inflector"

require "nxt/exceptions"

require "nxt/interfaces/base"
require "nxt/interfaces/usb"
require "nxt/interfaces/serialport"

require "nxt/connectors/input/color"
require "nxt/connectors/input/touch"
require "nxt/connectors/input/ultrasonic"
require "nxt/connectors/output/motor"

require "nxt/nxt_runner"
