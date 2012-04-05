require "nxt"

# The path to your NXT device, change this to run these examples by using the
# environment variable NXT_DEVICE.
device = ENV["NXT_DEVICE"] || "/dev/rfcomm0"
interface = NXT::Interface::SerialPort.new(device)

NXTRunner.new(interface) do |nxt|
  nxt.add_motor_output(:a, :front_motor)

  # Run the motor for 5 seconds, then stop.
  nxt.front_motor.power(100).duration(5).move()
  sleep(2)
  # Run the motor indefinitely.
  nxt.front_motor.move()
  sleep(5)
  # Stop the motor after our 5 second sleep.
  nxt.front_motor.stop()

  nxt.front_motor.rotations(2).power(50).move()
end
