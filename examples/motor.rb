require "nxt"

# The path to your NXT device, change this to run these examples by using the
# environment variable NXT_DEVICE.
device = ENV["NXT_DEVICE"] || "/dev/rfcomm0"
interface = NXT::Interface::SerialPort.new(device)

NXTRunner.new(interface) do |nxt|
  nxt.add_motor_output(:a, :front_motor)

  # Run the motor for 2 seconds, then stop.
  nxt.front_motor.duration(2).move

  sleep(2)

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
