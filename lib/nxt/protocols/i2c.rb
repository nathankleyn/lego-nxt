# frozen_string_literal: true

module NXT
  module Protocols
    # Communication to the NXT brick for digital sensors is done using the I2C
    # protocol. This module implements communication in that fashion,
    # abstracing the messages
    # we wish to send from the underlying protocol for ease-of-use.
    module I2C
      COMMAND_IDENTIFIER = {
        ls_get_status: 0x0E,
        ls_write: 0x0F,
        ls_read: 0x10
      }.freeze

      I2C_HEADER = 0x02

      # Format is I2C address, followed by the number of bytes expected in the response.
      I2C_CONSTANT_OPS = {
        read_version: [0x00, 8],
        read_product_id: [0x08, 8],
        read_sensor_type: [0x10, 8],
        read_factory_zero: [0x11, 1],
        read_factory_scale_factor: [0x12, 1],
        read_factory_scale_divisor: [0x13, 1],
        read_measurement_units: [0x14, 7]
      }.freeze

      # Format is the I2C address (all variable operations expect a 1 byte reponse).
      I2C_VARIABLE_OPS = {
        read_continuous_measurements_interval: 0x40,
        read_command_state: 0x41,
        read_measurement_byte_zero: 0x42,
        read_measurement_byte_one: 0x43,
        read_measurement_byte_two: 0x44,
        read_measurement_byte_three: 0x45,
        read_measurement_byte_four: 0x46,
        read_measurement_byte_five: 0x47,
        read_measurement_byte_six: 0x48,
        read_measurement_byte_seven: 0x49,
        read_actual_zero: 0x50,
        read_actual_scale_factor: 0x51,
        read_actual_scale_divisor: 0x52
      }.freeze

      # Format is I2C address, followed by the command. If the array is only
      # one member large, then the second byte is instead a value passed at
      # run-time, eg. the length of the interval to run the continuous
      # measuring on the ultrasonic sensor for.
      I2C_COMMANDS = {
        off_command: [0x41, 0x00],
        single_shot_command: [0x41, 0x01],
        continuous_measurement_command: [0x41, 0x02],
        event_capture_command: [0x41, 0x03],
        request_warm_reset: [0x41, 0x04],
        set_continuous_measurement_interval: [0x40],
        set_actual_zero: [0x50],
        set_actual_scale_factor: [0x51],
        set_actual_scale_divisor: [0x52]
      }.freeze

      def self.method_missing(name, *args)
        if I2C_CONSTANT_OPS.key?(name)
          run_constant_op(name)
        elsif I2C_VARIABLE_OPS.key?(name)
          run_variable_op(name)
        elsif I2C_COMMANDS.key?(name)
          run_command(name, *args)
        else
          super
        end
      end

      def self.respond_to_missing?(name, include_private = false)
        I2C_CONSTANT_OPS.key?(name) ||
          I2C_VARIABLE_OPS.key?(name) ||
          I2C_COMMANDS.key?(name) ||
          super
      end

      class << self
        private

        def run_constant_op(name)
          op = I2C_CONSTANT_OPS[name]
          addr = op[0]
          rx_len = op[1]

          [0, rx_len, I2C_HEADER, addr]
        end

        def run_variable_op(name)
          op = I2C_VARIABLE_OPS[name]
          addr = op
          rx_len = 1

          [0, rx_len, I2C_HEADER, addr]
        end

        def run_command(name, *args)
          op = I2C_COMMANDS[name]
          addr = op[0]
          rx_len = 0

          if op[1]
            data = [op[1]]
          elsif args[0]
            data = [args[0]]
          else
            raise "Missing argument for command #{name}"
          end

          [data.size, rx_len, I2C_HEADER, addr] + data
        end
      end
    end
  end
end
