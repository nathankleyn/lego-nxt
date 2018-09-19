module NXT
  module Connector
    # Holds implementations of connectors that are output based.
    module Output
      # Implements the "motor" output for the NXT 2.0 module.
      class Motor
        include NXT::Command::Output
        include NXT::Utils::Assertions
        extend NXT::Utils::Accessors

        DURATION_TYPE = %i[seconds degrees rotations].freeze
        DURATION_AFTER = %i[coast brake].freeze
        DIRECTION = %i[forwards backwards].freeze

        attr_accessor :port, :interface

        attr_combined_accessor :duration, 0
        attr_combined_accessor :duration_type, :seconds
        attr_combined_accessor :duration_after, :stop
        attr_combined_accessor :direction, :forwards

        attr_setter :direction, is_key_in: DIRECTION

        def initialize(port, interface)
          @port = port
          @interface = interface
        end

        def duration=(duration, options = {})
          raise(TypeError, 'Expected duration to be a number') unless duration.is_a?(Integer)

          @duration = duration

          self.duration_type = options[:type]
          self.duration_after = options[:after]

          case @duration_type
          when :rotations
            self.tacho_limit = @duration * 360
          when :degrees
            self.tacho_limit = @duration
          end
        end

        def forwards
          self.direction = :forwards
          self
        end

        def backwards
          self.direction = :backwards
          self
        end

        def stop(mode = :coast)
          self.power = 0
          self.mode = mode

          move
        end

        # takes block for response, or can return the response instead.
        def move
          update_output_state(duration > 0 && duration_type != :seconds)

          if duration > 0 && duration_type == :seconds
            wait_after_move
          else
            reset
          end
        end

        def reset
          self.duration = 0
          self.direction = :forwards
          self.power = 75
          self.mode = :motor_on
          self.regulation_mode = :idle
          self.run_state = :running
          self.tacho_limit = 0
        end
      end

      private

      def duration_type=(type)
        if !type.nil?
          assert_in(:type, type, DURATION_TYPE)
          @duration_type = type
        else
          @duration_type = :seconds
        end
      end

      def duration_after=(after)
        if !after.nil?
          unless @duration_type == :seconds
            raise(TypeError, 'The after option is only available when the unit duration is in seconds.')
          end

          assert_in(:after, after, DURATION_AFTER)
          @duration_after = after
        else
          @duration_after = :stop
        end
      end

      def wait_after_move
        sleep(duration)
        reset
        stop(duration_after)
      end
    end
  end
end
