class NXTRunner
  VALID_PORTS = [:a, :b, :c, :one, :two, :three, :four]

  attr_accessor :interface, :options

  # Accessors for ports on the NXT brick. These will be populate with the
  # appropriate instances of their respective connected sensors.
  attr_accessor :a, :b, :c
  attr_accessor :one, :two, :three, :four

  # We mandate that all added port connections have an identifier associated
  # with it. This is so that code is not fragile when port swapping needs to
  # be done.
  attr_reader :port_identifiers

  def initialize(interface, options = {})
    unless interface.is_a?(NXT::Interface::Base)
      raise InvalidInterfaceError.new("Provided interface is not a valid type.")
    end

    self.interface = interface
    self.options = options

    yield(self) if block_given?
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
    raise TypeError.new("Expected port to be a Symbol") unless port.is_a?(Symbol)
    raise TypeError.new("Expected identifier to be a Symbol") unless identifier.is_a?(Symbol)
    raise TypeError.new("Expected klass to be a Class") unless klass.is_a?(Class)

    unless VALID_PORTS.include?(port)
      raise TypeError.new("Expected port to be one of: :#{VALID_PORTS.join(", :")}")
    end

    # Makes a new instance of the class and pushes it into our accessor for
    # the given port.
    if self.send(port).nil?
      self.send("#{port}=", klass.new(port))
    else
      raise "Port #{port} is already set, call remove first!"
    end

    # Given that that succeeded, all that remains is to add the identifier
    # to our lookup Hash. We'll use this Hash later on within method_missing.
    @port_identifiers ||= {}
    @port_identifiers[identifier] = port
  end

  # Remove the assigned (if any) connector instance from the given
  # identifier.
  #
  # @param Symbol identifier The identifier to search for and remove.
  def remove(identifier)
    !!@port_identifiers.delete(identifier)
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
      # We don't use a splat here for the args, because otherwise when
      # people don't pass in the correct number of params, it says
      # at minimum "1 of 3" args passed...
      define_method("add_#{const.to_s.underscore}_#{type_const.to_s.underscore}") do |port, identifier|
        self.add(port, identifier, NXT::Connector.const_get(type_const).const_get(const))
      end
    end
  end
end
