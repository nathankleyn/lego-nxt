module NXT
  module Connector
    module Output
      class Motor
        include NXT::Command::Output
        include NXT::Utils::Assertions
        extend NXT::Utils::Accessors

        DURATION_TYPE = [:seconds, :degrees, :rotations].freeze
        DURATION_AFTER = [:coast, :brake].freeze
        DIRECTION = [:forwards, :backwards].freeze

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
          raise TypeError.new('Expected duration to be a number') unless duration.is_a?(Integer)
          @duration = duration

          if options.include?(:type)
            type = options[:type]
            assert_in(:type, type, DURATION_TYPE)
            @duration_type = type
          else
            @duration_type = :seconds
          end

          if options.include?(:after)
            if @duration_type == :seconds
              after = options[:after]
              assert_in(:after, after, DURATION_AFTER)
              @duration_after = after
            else
              raise TypeError.new('The after option is only available when the unit duration is in seconds.')
            end
          else
            @duration_after = :stop
          end

          case @duration_type
          when :rotations
            self.tacho_limit = @duration * 360
          when :degrees
            self.tacho_limit = @duration
          end

          self
        end

        def forwards
          self.direction = :forwards
          self
        end

        def backwards
          self.direction = :backwards
          self
        end

        def stop(type = :coast)
          self.power = 0
          self.mode = :coast

          self.move
        end

        # takes block for response, or can return the response instead.
        def move
          response_required = false

          if self.duration > 0 && self.duration_type != :seconds
            response_required = true
          end

          set_output_state(response_required)

          if self.duration > 0 && self.duration_type == :seconds
            sleep(self.duration)
            self.reset
            self.stop(self.duration_after)
          else
            self.reset
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
    end
  end
end
