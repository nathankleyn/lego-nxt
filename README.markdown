# NXT

Control a Lego NXT 2.0 brick using Ruby code. This library works by piping
commands over a serial connection to the brick, allowing you to write Ruby
scripts to control your bot. This means you can use both the Bluetooth and USB
serial ports provided on the brick as interfaces within your code.

This project used to be based on "ruby-nxt", and Tony Buser's subsequent rewrite
"nxt". It is now a complete rewrite, based heavily in some parts on the
aforesaid projects internally, but with a brand new external API that should
prove cleaner and easier to work with.

This code implements direct command, as outlined in "Appendix 2-LEGO MINDSTORMS
NXT Direct Commands.pdf".

Not all functionality is implemented yet!

For instructions on creating a bluetooth serial port connection:

* Linux: http://tonybuser.com/bluetooth-serial-port-to-nxt-in-linux
* Max OSX: http://tonybuser.com/bluetooth-serial-port-to-nxt-in-osx
* Windows: http://tonybuser.com/ruby-serialportnxt-on-windows
