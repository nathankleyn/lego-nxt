module NXT
  module Command
    # An implementation of all the input related NXT commands:
    #
    # * SETINPUTMODE
    # * GETINPUTVALUES
    # * RESETINPUTSCALEDVALUE
    #
    # This class can also be used to talk to other third-party accessories
    # connected in the input ports on the NXT brick.
    module Input
      include NXT::Command::Base
      extend NXT::Utils::Accessors

      COMMAND_IDENTIFIER = {
        set_input_mode: 0x05,
        get_input_values: 0x07,
        reset_input_scaled_value: 0x08,
        ls_get_status: 0x0E,
        ls_write: 0x0F,
        ls_read: 0x10
      }.freeze

      # The sensor type enum. This is a list of possible values when setting the
      # sensor type byte.
      #
      # Reference: Appendix 2, Page 7
      SENSOR_TYPE = {
        no_sensor: 0x00,
        switch: 0x01,
        temperature: 0x02,
        reflection: 0x03,
        angle: 0x04,
        light_active: 0x05,
        light_inactive: 0x06,
        sound_db: 0x07,
        sound_dba: 0x08,
        custom: 0x09,
        lowspeed: 0x0A,
        lowspeed_9v: 0x0B,
        no_of_sensor_types: 0x0C
      }.freeze

      # The sensor mode enum. This is a list of possible values when setting the
      # sensor mode byte.
      #
      # Reference: Appendix 2, Page 7
      SENSOR_MODE = {
        raw: 0x00,
        boolean: 0x20,
        transition_cnt: 0x40,
        period_counter: 0x60,
        pct_full_scale: 0x80,
        celsius: 0xA0,
        fahrenheit: 0xC0,
        angle_steps: 0xE0,
        slope: 0x1F,
        mode_mask: 0x00
      }.freeze

      attr_combined_accessor :sensor_type, :no_sensor
      attr_combined_accessor :sensor_mode, :raw

      attr_setter :sensor_type, is_key_in: SENSOR_TYPE
      attr_setter :sensor_mode, is_key_in: SENSOR_MODE

      def command_type
        COMMAND_TYPES[:direct]
      end

      def update_input_mode(response_required = false)
        send_and_receive(
          COMMAND_IDENTIFIER[:set_input_mode],
          [
            SENSOR_TYPE[sensor_type],
            SENSOR_MODE[sensor_mode]
          ],
          response_required
        )
      end

      def input_values
        # TODO: Parse this response and return hash or something similar.
        send_and_receive(COMMAND_IDENTIFIER[:get_input_values], [], response_required)
      end

      def reset_input_scaled_value
        # TODO: Parse this response and return hash or something similar.
        send_and_receive(COMMAND_IDENTIFIER[:reset_input_scaled_value], [], response_required)
      end

      def ls_get_status(response_required = false)
        send_and_receive(COMMAND_IDENTIFIER[:ls_get_status], [], response_required)
      end

      def ls_write(bytes, response_required = false)
        send_and_receive(COMMAND_IDENTIFIER[:ls_write], bytes, response_required)
      end

      def ls_read(response_required = false)
        send_and_receive(COMMAND_IDENTIFIER[:ls_read], [], response_required)
      end
    end
  end
end
