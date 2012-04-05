module NXT
  module Connector
    module Output
      class Motor
        include NXT::Command::Output

        VALID_DURATION_TYPE = [:seconds, :degrees, :rotations].freeze
        VALID_DIRECTIONS = [:forwards, :backwards].freeze

        attr_accessor :port, :interface

        attr_combined_accessor :duration, 0
        attr_combined_accessor :duration_type, :seconds
        attr_combined_accessor :direction, :forwards

        def initialize(port, interface)
          @port = port
          @interface = interface
        end

        def duration=(duration)
          raise TypeError.new("Expected duration to be a number") unless duration.is_a?(Integer)
          @duration = duration
          self
        end

        def duration_type=(duration_type)
          unless VALID_DURATION_TYPE.include?(duration_type)
            raise TypeError.new("Expected duration type to be one of: :#{VALID_DURATION_TYPE.join(", :")}")
          end

          @duration_type = duration_type
          self
        end

        # Use define_method for these three methods.
        def seconds=(seconds)
          self.duration_type = :seconds
          self.duration = seconds
        end

        def degrees=(degrees)
          self.duration_type = :degrees
          self.duration = degrees
        end

        def rotations=(rotations)
          self.duration_type = :rotations
          self.duration = rotations
        end

        def direction=(direction)
          unless VALID_DIRECTIONS.include?(direction)
            raise TypeError.new("Expected direction to be one of: :#{VALID_DIRECTIONS.join(", :")}")
          end

          @direction = direction
          self
        end

        def forwards
          self.direction = :forwards
        end

        def backwards
          self.direction = :backwards
        end

        def stop
          # set_output_state(
          #   # Port
          #   self.port,
          #   # Power
          #   0,
          #   # Mode
          #   MODE[:coast],
          #   # Regulation mode
          #   REGULATION_MODE[:idle],
          #   # Tacho limit
          #   0
          # )
        end

        # takes block for response, or can return the response instead.
        def move
          set_output_state
        end

        def reset

        end
      end
    end
  end
end
