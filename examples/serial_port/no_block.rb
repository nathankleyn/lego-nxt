require 'lego-nxt'

# The path to your NXT device, change this to run these examples by using the
# environment variable NXT_DEVICE.
device = ENV['NXT_DEVICE'] || '/dev/rfcomm0'

nxt = NXTBrick.new(:serial_port, device)

begin
  nxt.connect

  # Do whatever with the `nxt` instance here; we'll spin the wheels for 2 seconds
  # as an example.
  nxt.add_motor_output(:a, :front_motor)
  nxt.front_motor.duration(2).move
ensure
  # You should always make sure this gets called by putting it in an `ensure`
  # block.
  nxt.disconnect
end