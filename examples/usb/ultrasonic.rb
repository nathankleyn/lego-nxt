# frozen_string_literal: true

require 'lego_nxt'

NXTBrick.new(:usb) do |nxt|
  nxt.add_ultrasonic_input(:one, :sonar)

  nxt.sonar.start

  sleep(2)

  while nxt.sonar.distance < 5
    sleep(2)
    puts "Distance: #{nxt.sonar.distance}"
  end

  puts 'Got it!'
end
