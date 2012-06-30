# NXT

Control a Lego NXT 2.0 brick using Ruby code. This library works by piping
commands over a serialport connection to the brick, allowing you to write Ruby
scripts to control your bot. This means you can use both the Bluetooth and USB
serial ports provided on the brick as interfaces within your code.

This project used to be based on "ruby-nxt", and Tony Buser's subsequent rewrite
"nxt". It is now a complete rewrite, based heavily in some parts on the
aforesaid projects internally, but with a brand new external API that should
prove cleaner and easier to work with.

This code implements direct command, as outlined in "Appendix 2-LEGO MINDSTORMS
NXT Direct Commands.pdf". Not all functionality is implemented yet!

## Getting Started

### Connect to Your NXT Brick

In order to start coding with your NXT, you'll need to set up either a
Bluetooth or USB connection to it. Follow one of the below set of steps, and
make a note of the `/dev/*` address you end up using to point to the NXT.

### Creating a Bluetooth Serialport Connection

For instructions on creating a bluetooth serialport connection:

* Linux: http://tonybuser.com/bluetooth-serial-port-to-nxt-in-linux
* Max OSX: http://tonybuser.com/bluetooth-serial-port-to-nxt-in-osx
* Windows: http://tonybuser.com/ruby-serialportnxt-on-windows

### Creating a USB Serialport Connection

TODO

Once you have your NXT Connected

## Documentation and Examples

The NXT project has been heavily documented using nice, clean, human readable
markdown. YARD is used to generated the docs, and the options have been included
in our .yardopts file, so simply run a YARD server to read them:

    yard server

This documents the API, both internal and external. For bite-sized chunks of NXT
code that is much more appropriate for beginners,
[have a look at the examples](https://github.com/nathankleyn/nxt/tree/master/examples).

In addition to this, you might find the tests quite helpful. There are currently
only RSpec unit tests, which can be found in the `spec` directory; the plan is
to add some decent feature tests soon.
