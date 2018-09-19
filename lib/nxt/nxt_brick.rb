# This class is the entry point for end-users creating their own list of
# commands to execute remotely on a Lego NXT brick.
#
# An instance of this class provides all the endpoints necessary to:
#
# * educate the API on the connected input and output devices; and,
# * access these input and output devices and run commands using them.
#
# @example Creating an instance using a block, with one motor output.
#
#   NXTBrick.new(interface) do |nxt|
#     nxt.add_motor_output(:a, :front_left)
#   end
#
# @example Creating an instance without a block, with one motor and one light sensor.
#
#   nxt = NXTBrick.new(interface)
#   nxt.add_motor_output(:a, :front_left)
#   # ...
#   nxt.disconnect
class NXTBrick
  include NXT::Exceptions
  include NXT::Utils::Assertions

  # An enumeration of possible ports, both input and output, that the NXT brick
  # can have connectors attached to.
  PORTS = %i[a b c one two three four].freeze

  # Get the instance of the interface that this runner class is using to connect
  # to the NXT brick.
  attr_accessor :interface

  # Accessors for output ports on the NXT brick. These will be populated with
  # the appropriate instances of their respective output connectors.
  attr_reader :a, :b, :c

  # Accessors for input ports on the NXT brick. These will be populated with the
  # appropriate instances of their respective input connectors.
  attr_reader :one, :two, :three, :four

  # We mandate that all added port connections have an identifier associated
  # with it. This is so that code is not fragile when port swapping needs to
  # be done.
  attr_reader :port_identifiers

  def initialize(interface_type, *interface_args)
    @port_identifiers = {}
    interface_type = interface_type.to_s.classify

    unless NXT::Interface.constants.include?(interface_type.to_sym)
      raise(InvalidInterfaceError, "There is no interface of type #{interface_type}.")
    end

    @interface = NXT::Interface.const_get(interface_type).new(*interface_args)

    return unless block_given?

    begin
      connect
      yield(self)
    ensure
      disconnect
    end
  end

  # Connect using the given interface to the NXT brick.
  def connect
    @interface.connect
  end

  # Close the connection to the NXT brick, and dispose of any resources that
  # this instance of NXTBrick is using. Any commands run against this runner
  # after calling disconnect will fail.
  def disconnect
    @interface.disconnect
  end

  # Add a new connector instance, binding a specific identifier to the given
  # port.
  #
  # If the given port already is bound, an exception will be thrown. The
  # instance given though can be of any class, presuming it talks the
  # correct language.
  #
  # @param Symbol port The port to bind to.
  # @param Symbol identifier The identifier to associate with this port.
  # @param Class klass The Class to instantiate as the instance of this
  #                    port. There is no limitation on what type this can
  #                    be, though it must be able to hook in correctly
  #                    with the NXT library.
  def add(port, identifier, klass)
    assert_in('port', port, PORTS)
    assert_responds_to('identifier', identifier, :to_sym)
    assert_type('klass', klass, Class)

    if respond_to?(identifier)
      if instance_variable_get(:"@#{port}").nil?
        raise(
          InvalidIdentifierError,
          "Cannot use identifier #{identifier}, a method on #{self.class} is already using it."
        )
      end

      raise(PortTakenError, "Port #{port} is already set, call remove first")
    end

    define_port_handler_method(port, identifier, klass)
  end

  # Remove the assigned (if any) connector instance from the given
  # identifier.interface
  #
  # @param Symbol identifier The identifier to search for and remove.
  def remove(identifier)
    assert_responds_to('identifier', identifier, :to_sym)
    !@port_identifiers.delete(identifier.to_sym).nil?
  end

  # This will dynamically add methods like:
  #
  # * add_light_input
  # * add_motor_output
  # * add_ultrasonic_input
  #
  # This means they don't have to provide the class each and every time. For
  # connectors they have added themselves, it's likely best to use the
  # {#add} method.
  NXT::Connector.constants.each do |type_const|
    NXT::Connector.const_get(type_const).constants.each do |const|
      # We don't use a splat here for the args, because that way when
      # people don't pass in the correct number of params, it says helpfully
      # '1 of 2' args passed (or something similar).
      define_method("add_#{const.to_s.underscore}_#{type_const.to_s.underscore}") do |port, identifier|
        add(port, identifier, NXT::Connector.const_get(type_const).const_get(const))
      end
    end
  end

  private

  def define_port_handler_method(port, identifier, klass)
    port_variable = :"@#{port}"

    # Makes a new instance of the class and pushes it into our instance variable
    # for the given port.
    instance_variable_set(port_variable, klass.new(port, interface))

    # Given that that succeeded, all that remains is to add the identifier
    # to our lookup Hash. We'll use this Hash later on within method_missing.
    @port_identifiers[identifier.to_sym] = port

    # Define a method on the eigenclass of this instance.
    (class << self; self; end).send(:define_method, identifier.to_sym) do
      instance_variable_get(port_variable)
    end
  end
end
