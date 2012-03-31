module NXT
  module Command

    # An implementation of all the output related NXT commands:
    #
    # * setoutputstate
    # * getoutputstate
    #
    # This is used predominantly to interface with the servo-motor connectors
    # that come prepackaged with NXT kits.
    #
    # This class can also be used to talk to other third-party accessories
    # connected in the output ports on the NXT brick.
    #
    # This class does not actually talk to the chosen interface for the NXT
    # brick. Instead, it outputs messages in byte arrays ready to be serialised
    # to the brick over the appropriate interface from within the {NXT::Brick}
    # class.
    module Output

      # Can be :direct, or :system.
      @@command_type = :direct

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

      def self.set_output_state(port, power, mode, regulation_mode, run_state, tacho_limit, response_required = false)
        response_required = response_required_to_byte(@@command_type, response_required)
        port = port_to_byte(port)

        unless power >= -100 && power <= 100
          "Invalid value for power."
        end

        mode = MODE[mode]
        regulation_mode = REGULATION_MODE[regulation_mode]
        run_state = RUN_STATE[run_state]

        # Pack this value into a 32-bit unsigned little-endian binary string,
        # then unpack it into 4 8 bit unsigned integer chunks. We are
        # converting the passed in value to a little endian, unsigned long
        # value.
        tacho_limit = [tacho_limit].pack("V").unpack("C4")

        [port, power, mode, regulation_mode, run_state, tacho_limit].flatten
      end

    end

  end
end
