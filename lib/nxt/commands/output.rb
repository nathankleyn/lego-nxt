require 'nxt/utils/accessors'

module NXT
  module Command
    # An implementation of all the output related NXT commands:
    #
    # * SETOUTPUTSTATE
    # * GETOUTPUTSTATE
    #
    # This is used predominantly to interface with the servo-motor connectors
    # that come prepackaged with NXT kits.
    #
    # This class can also be used to talk to other third-party accessories
    # connected in the output ports on the NXT brick.
    module Output
      include NXT::Command::Base
      extend NXT::Utils::Accessors

      @@command_type = COMMAND_TYPES[:direct]

      COMMAND_IDENTIFIER = {
        set_output_state: 0x04,
        get_output_state: 0x06
      }.freeze

      # The mode enum. This is a list of possible values when setting the mode
      # byte.
      #
      # Reference: Appendix 2, Page 6
      MODE = {
        # Motor will rotate freely.
        # NOTE: This is not documented in the Appendixes.
        coast: 0x00,
        # Turn on the specified motor.
        motor_on: 0x01,
        # Use run/brake instead of run/float in PWM. This means the voltage is
        # not allowed to float between PWM pulses, improving accuracy at the
        # expense of greater power usage.
        brake: 0x02,
        # Turns on the regulation. This is required when setting a regulation
        # mode setting.
        regulated: 0x04
      }.freeze

      # The regulation mode enum. This is a list of possible values when
      # setting the regulation mode byte.
      #
      # Reference: Appendix 2, Page 6
      REGULATION_MODE = {
        # No regulation will be enabled.
        idle: 0x00,
        # Power control will be enabled on specific output.
        motor_speed: 0x01,
        # Synchronisation will be enabled. This requires two output ports to
        # have this enabled before it will work.
        motor_sync: 0x02
      }.freeze

      # The run state enum. This is a list of possible values when setting the
      # run state byte.
      #
      # Reference: Appendix 2, Page 6
      RUN_STATE = {
        # Output will be idle.
        idle: 0x00,
        # Output will ramp-up to the desired speed.
        ramp_up: 0x10,
        # Output will be running.
        running: 0x20,
        # Output will ramp-down to the desired speed.
        ramp_down: 0x40
      }.freeze

      attr_combined_accessor :power, 75
      attr_combined_accessor :mode, :motor_on
      attr_combined_accessor :regulation_mode, :idle
      attr_combined_accessor :run_state, :running
      attr_combined_accessor :tacho_limit, 0

      attr_setter :power, is: Integer
      attr_setter :mode, is_key_in: MODE
      attr_setter :regulation_mode, is_key_in: REGULATION_MODE
      attr_setter :run_state, is_key_in: RUN_STATE
      attr_setter :tacho_limit, is: Integer

      def set_output_state(response_required = false)
        # Pack this value into a 32-bit unsigned little-endian binary string,
        # then unpack it into 4 8 bit unsigned integer chunks. We are
        # converting the passed in value to a little endian, unsigned long
        # value.
        tacho_limit_as_bytes = [self.tacho_limit].pack('V').unpack('C4')

        send_and_receive(:set_output_state, [
          self.power,
          MODE[self.mode],
          REGULATION_MODE[self.regulation_mode],
          0, # turn ratio
          RUN_STATE[self.run_state]
        ] + tacho_limit_as_bytes, response_required)
      end

      def get_output_state
        # TODO: Parse this response and return hash or something similar.
        send_and_receive(:get_output_state)
      end
    end
  end
end
