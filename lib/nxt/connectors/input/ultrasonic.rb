module NXT
  module Connector
    module Input
      # Implements the "ultrasonic" sensor for the NXT 2.0 module.
      class Ultrasonic
        include NXT::Command::Input
        include NXT::Command::LowSpeed
        include NXT::Utils::Assertions
        extend NXT::Utils::Accessors

        # Exception thrown by distance! when the sensor cannot determine the distance.
        class UnmeasurableDistance < RuntimeError; end

        UNIT = %i[centimeters inches].freeze

        attr_accessor :port, :interface

        attr_combined_accessor :unit, :centimeters

        attr_setter :unit, is_key_in: UNIT

        def initialize(port, interface)
          @port = port
          @interface = interface
        end

        def distance
          ls_write(NXT::Protocols::I2C.read_measurement_byte_0)

          while ls_get_status < 1
            sleep(0.1)
            # TODO: implement timeout so we don't get stuck if the expected data never comes
          end

          distance = ls_read[0]

          if @unit == :centimeters
            distance.to_i
          else
            (distance * 0.3937008).to_i
          end
        end

        def distance!
          d = distance
          raise UnmeasurableDistance if d == 255
          d
        end

        def start
          sensor_type(:lowspeed_9v)
          sensor_mode(:raw)

          update_input_mode
          ls_clear_buffer

          # set sensor to continuously send pings
          ls_write(NXT::Protocols::I2C.continuous_measurement_command)
        end
      end
    end
  end
end
