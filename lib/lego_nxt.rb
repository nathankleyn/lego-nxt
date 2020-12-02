# frozen_string_literal: true

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'active_support/inflector'

require 'nxt/patches/module'
require 'nxt/patches/string'

require 'nxt/exceptions'

require 'nxt/utils/assertions'
require 'nxt/utils/accessors'

require 'nxt/interface/base'
require 'nxt/interface/usb'
require 'nxt/interface/serial_port'

require 'nxt/protocols/i2c'

require 'nxt/commands/base'
require 'nxt/commands/input'
require 'nxt/commands/low_speed'
require 'nxt/commands/output'
require 'nxt/commands/program'
require 'nxt/commands/sound'
require 'nxt/commands/tone'

require 'nxt/connector/input/base'
require 'nxt/connector/input/color'
require 'nxt/connector/input/touch'
require 'nxt/connector/input/ultrasonic'
require 'nxt/connector/output/base'
require 'nxt/connector/output/motor'

require 'nxt/nxt_brick'
