require 'lego-nxt'

NXTBrick.new(:usb) do |nxt|
  # This is the important part: with this NXT library, you add all your input
  # and ouput and inputs here at the start. When you add one, you give it a
  # name, and that's how you refer to it from then onwards! It's pretty cool,
  # as it reads almost like plain English.
  nxt.add_motor_output(:a, :front_motor)

  # Run the motor for 5 rotations instead.
  nxt.front_motor.duration(5, type: :rotations).move

  loop do
    puts 'Waiting...'
    sleep 0.5
    break if nxt.front_motor.stopped?
  end

  puts 'I am like, done rotationing dude.'
end
