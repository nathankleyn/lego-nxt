require 'spec_helper'

describe NXTBrick do
  subject do
    NXTBrick.new(:usb)
  end

  describe 'accessors' do
    it 'should have read/write accessors for @interface' do
      should respond_to(:interface)
      should respond_to(:interface=)
    end

    it 'should have a read accessor for @a' do
      should respond_to(:a)
      should_not respond_to(:a=)
    end

    it 'should have a read accessor for @b' do
      should respond_to(:b)
      should_not respond_to(:b=)
    end

    it 'should have a read accessor for @c' do
      should respond_to(:c)
      should_not respond_to(:c=)
    end

    it 'should have a read accessor for @one' do
      should respond_to(:one)
      should_not respond_to(:one=)
    end

    it 'should have a read accessor for @two' do
      should respond_to(:two)
      should_not respond_to(:two=)
    end

    it 'should have a read accessor for @three' do
      should respond_to(:three)
      should_not respond_to(:three=)
    end

    it 'should have a read accessor for @four' do
      should respond_to(:four)
      should_not respond_to(:four=)
    end

    it 'should have a read accessor for @port_identifiers' do
      should respond_to(:port_identifiers)
      should_not respond_to(:port_identifiers=)
    end
  end

  describe '#initialize' do
    it 'should raise an exception if an invalid type of interface is given' do
      expect do
        NXTBrick.new(:foobar)
      end.to raise_exception(InvalidInterfaceError)
    end

    it 'should set the interface to the incomming argument' do
      subject.interface.should be_an_instance_of(NXT::Interface::Usb)
    end

    it 'should call yield if given a block, passing self' do
      block_called = false

      NXT::Interface::Usb.any_instance.stub(:connect)

      NXTBrick.new(:usb) do |nxt|
        block_called = true
        nxt.should be_an_instance_of(NXTBrick)
      end

      block_called.should be_true
    end
  end

  describe '#connect' do
    before do
      @interface = Object.new
      subject.instance_variable_set(:@interface, @interface)
    end

    it 'should call connect on the interface' do
      @interface.should_receive(:connect)
      subject.connect
    end
  end

  describe '#disconnect' do
    before do
      @interface = Object.new
      subject.instance_variable_set(:@interface, @interface)
    end

    it 'should call disconnect on the interface' do
      @interface.should_receive(:disconnect)
      subject.disconnect
    end
  end

  describe '#add' do
    before do
      @port = :a
      @identifier = :hello
      @class_stub = Class.new
      @class_stub.stub(:new)

      subject.stub(:define_port_handler_method)
    end

    it 'should raise an exception if an invalid port number or letter is given' do
      expect do
        subject.add(:invalid_port, @identifier, @class_stub)
      end.to raise_exception(TypeError, 'Expected port to be one of: :a, :b, :c, :one, :two, :three, :four')
    end

    it 'should raise an exception if an invalid type of identifier is given' do
      expect do
        subject.add(@port, 123, @class_stub)
      end.to raise_exception(TypeError, 'Expected identifier to respond to: to_sym')
    end

    it 'should raise an exception if an invalid type of klass is given' do
      expect do
        subject.add(@port, @identifier, 'not a class')
      end.to raise_exception(TypeError, 'Expected klass to be of type Class')
    end

    it 'should raise an exception if trying to use an identifier that is the name of a defined methodz' do
      subject.stub(@identifier)

      expect do
        subject.add(@port, @identifier, @class_stub)
      end.to raise_error(InvalidIdentifierError, "Cannot use identifier #{@identifier}, a method on NXTBrick is already using it.")
    end

    it 'should raise an exception if the port given is already set' do
      subject.stub(@identifier)
      subject.instance_variable_set(:"@#{@port}", 'some value already there')

      expect do
        subject.add(@port, @identifier, @class_stub)
      end.to raise_error(PortTakenError, "Port #{@port} is already set, call remove first")
    end

    it 'should call #define_port_handler_method' do
      subject.should_receive(:define_port_handler_method).with(@port, @identifier, @class_stub)
      subject.add(@port, @identifier, @class_stub)
    end
  end

  describe '#remove' do
    it 'should raise an exception if an invalid type of identifier is given' do
      expect do
        subject.remove(123)
      end.to raise_exception(TypeError, 'Expected identifier to respond to: to_sym')
    end

    it 'should remove any matching identifiers' do
      identifier = :hello_world
      port_identifiers = {}
      subject.instance_variable_set(:@port_identifiers, port_identifiers)

      port_identifiers.should_receive(:delete).with(identifier).once()
      subject.remove(identifier)
    end

    it 'should return a boolean indicating whether it removed anything' do
      identifier = :hello_world
      port_identifiers = {}
      port_identifiers[identifier] = true
      subject.instance_variable_set(:@port_identifiers, port_identifiers)

      return_value = subject.remove(identifier)
      return_value.should be_true

      port_identifiers.should_not include(identifier)

      return_value = subject.remove(identifier)
      return_value.should be_false
    end
  end

  describe '#define_port_handler_method' do
    before do
      @port = :a
      @identifier = :hello
      @class_stub = Class.new
      @class_stub.stub(:new)
    end

    it 'should create a new instance of the passed klass and store it in the attribute for the given port' do
      class_return_stub = stub()
      @class_stub.should_receive(:new) do
        class_return_stub
      end.with(@port, an_instance_of(NXT::Interface::Usb)).once()

      subject.send(:define_port_handler_method, @port, @identifier, @class_stub)

      subject.send(@port).should equal(class_return_stub)
    end

    it 'should set up the port identifiers correctly' do
      subject.send(:define_port_handler_method, @port, @identifier, @class_stub)
      subject.port_identifiers[@identifier].should equal(@port)
    end
  end
end
