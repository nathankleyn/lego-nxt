$:.unshift(File.dirname(__FILE__))

require 'active_support/inflector'

require 'nxt/patches/module'

require 'nxt/exceptions'

require 'nxt/utils/assertions'
require 'nxt/utils/accessors'

require 'nxt/interfaces/base'
require 'nxt/interfaces/usb'
require 'nxt/interfaces/serial_port'

require 'nxt/commands/base'
require 'nxt/commands/input'
require 'nxt/commands/output'
require 'nxt/commands/program'
require 'nxt/commands/sound'
require 'nxt/commands/tone'

require 'nxt/connectors/input/color'
require 'nxt/connectors/input/touch'
require 'nxt/connectors/input/ultrasonic'
require 'nxt/connectors/output/motor'

require 'nxt/nxt_brick'

require 'pry'