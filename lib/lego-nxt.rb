$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'active_support/inflector'

require 'nxt/patches/module'
require 'nxt/patches/string'

require 'nxt/exceptions'

require 'nxt/utils/assertions'
require 'nxt/utils/accessors'

require 'nxt/interfaces/base'
require 'nxt/interfaces/usb'
require 'nxt/interfaces/serial_port'

require 'nxt/protocols/i2c'

require 'nxt/commands/base'
require 'nxt/commands/input'
require 'nxt/commands/low_speed'
require 'nxt/commands/output'
require 'nxt/commands/program'
require 'nxt/commands/sound'
require 'nxt/commands/tone'

require 'nxt/connectors/input/base'
require 'nxt/connectors/input/color'
require 'nxt/connectors/input/touch'
require 'nxt/connectors/input/ultrasonic'
require 'nxt/connectors/output/base'
require 'nxt/connectors/output/motor'

require 'nxt/nxt_brick'
