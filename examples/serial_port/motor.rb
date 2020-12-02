# frozen_string_literal: true

require 'lego_nxt'

# The path to your NXT device, change this to run these examples by using the
# environment variable NXT_DEVICE.
device = ENV['NXT_DEVICE'] || '/dev/rfcomm0'

NXTBrick.new(:serial_port, device) do |nxt|
  # This is the important part: with this NXT library, you add all your input
  # and ouput and inputs here at the start. When you add one, you give it a
  # name, and that's how you refer to it from then onwards! It's pretty cool,
  # as it reads almost like plain English.
  nxt.add_motor_output(:a, :front_motor)

  # Run the motor for 2 seconds, then stop.
  nxt.front_motor.duration(2).move

  sleep(2) # FIXME: Shouldn't need to do this.

  # Run the motor for 2 seconds backwards, then stop.
  nxt.front_motor.duration(2).backwards.move

  sleep(2) # FIXME: Shouldn't need to do this.

  # Run the motor for 5 rotations instead.
  nxt.front_motor.duration(5, type: :rotations).move

  sleep(7) # FIXME: Shouldn't need to do this.

  # Now run the motor for 360 degrees.
  nxt.front_motor.duration(360, type: :degrees).move

  sleep(2) # FIXME: Shouldn't need to do this.

  # Start the motor running indefinitely.
  nxt.front_motor.move

  sleep(3)

  # Stop the motor after it's been running for 3 seconds.
  nxt.front_motor.stop
end
