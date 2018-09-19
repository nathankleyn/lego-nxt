require 'lego-nxt'

nxt = NXTBrick.new(:usb)

begin
  nxt.connect

  # Do whatever with the `nxt` instance here; we'll spin the wheels for 2 seconds
  # as an example.
  nxt.add_motor_output(:a, :front_motor)
  nxt.front_motor.duration(2).move
  nxt.front_motor.stop(:brake)
ensure
  # You should always make sure this gets called by putting it in an `ensure`
  # block.
  nxt.disconnect
end
