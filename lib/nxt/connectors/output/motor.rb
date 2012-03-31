module NXT
  module Connector
    module Output
      class Motor
        extend NXT::Command::Output

        VALID_DURATION_TYPE = [:seconds, :degrees, :rotations].freeze
        VALID_DIRECTIONS = [:forwards, :backwards].freeze

        attr_accessor :port

        def initialize(port)
          @port = port
        end

        def duration
          @duration ||= 0
        end

        def duration=(duration)
          # FIXME: Duck typing here instead?
          raise TypeError.new("Expected duration to be a number") unless duration.is_a?(Integer)

          @duration = duration

          # For chaining
          self
        end

        def duration_type
          @duration_type ||= :seconds
        end

        def duration_type=(duration_type)
          unless VALID_DURATION_TYPE.include?(duration_type)
            raise TypeError.new("Expected duration type to be one of: :#{VALID_DURATION_TYPE.join(", :")}")
          end

          @duration_type = duration_type

          # For chaining
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

        def direction
          @direction ||= :forwards
        end

        def direction=(direction)
          unless VALID_DIRECTIONS.include?(direction)
            raise TypeError.new("Expected direction to be one of: :#{VALID_DIRECTIONS.join(", :")}")
          end

          @direction = direction

          # For chaining
          self
        end

        def forwards
          self.direction = :forwards
        end

        def backwards
          self.direction = :backwards
        end

        def power
          @power ||= 75
        end

        def power=(power)
          # FIXME: Duck typing here instead?
          raise TypeError.new("Expected duration to be a number") unless duration.is_a?(Integer)

          @power = power

          # For chaining
          self
        end

        def mode
          @mode ||= MODE[:coast]
        end

        def mode=(mode)
          unless MODE.include?(mode)
            raise TypeError.new("Expected mode to be one of: :#{MODE.join(", :")}")
          end

          @mode = mode

          # For chaining
          self
        end

        def regulation_mode
          @regulation_mode ||= REGULATION_MODE[:idle]
        end

        def regulation_mode=(regulation_mode)
          unless REGULATION_MODE.include?(mode)
            raise TypeError.new("Expected regulation mode to be one of: :#{REGULATION_MODE.join(", :")}")
          end

          @regulation_mode = regulation_mode

          # For chaining
          self
        end

        def tacho_limit
          @tacho_limit ||= 0
        end

        def tacho_limit=(tacho_limit)
          # FIXME: Duck typing here instead?
          raise TypeError.new("Expected tacho limit to be a number") unless tacho_limit.is_a?(Integer)

          @tacho_limit = tacho_limit

          # For chaining
          self
        end

        def degrees=(degrees)

        end

        def stop
          NXT::Command::Output.set_output_state(
            # Port
            self.port,
            # Power
            0,
            # Mode
            NXT::Command::Output::MODE[:coast],
            # Regulation mode
            NXT::Command::Output::REGULATION_MODE[:idle],
            # Tacho limit
            0
          )
        end

        # takes block for response, or can return it instead.
        def move()

          NXT::Command::Output.set_output_state(
            # Port
            self.port,
            # Power
            self.power,
            # Mode
            ,
            # Regulation mode
            NXT::Command::Output::REGULATION_MODE[:running],
            # Tacho limit
            0
          )
        end

        def reset

        end
      end
    end
  end
end
