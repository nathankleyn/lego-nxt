require "spec_helper"

describe NXTRunner do
  before do
    @interface = stub(
      is_a?: true
    )
  end

  subject do
    NXTRunner.new(@interface)
  end

  describe "accessors" do
    it "should have read/write accessors for @interface" do
      should respond_to(:interface)
      should respond_to(:interface=)
    end

    it "should have read/write accessors for @options" do
      should respond_to(:options)
      should respond_to(:options=)
    end

    it "should have read/write accessors for @a" do
      should respond_to(:a)
      should respond_to(:a=)
    end

    it "should have read/write accessors for @b" do
      should respond_to(:b)
      should respond_to(:b=)
    end

    it "should have read/write accessors for @c" do
      should respond_to(:c)
      should respond_to(:c=)
    end

    it "should have read/write accessors for @one" do
      should respond_to(:one)
      should respond_to(:one=)
    end

    it "should have read/write accessors for @two" do
      should respond_to(:two)
      should respond_to(:two=)
    end

    it "should have read/write accessors for @three" do
      should respond_to(:three)
      should respond_to(:three=)
    end

    it "should have read/write accessors for @four" do
      should respond_to(:four)
      should respond_to(:four=)
    end

    it "should have a read accessor for @port_identifiers" do
      should respond_to(:port_identifiers)
      should_not respond_to(:port_identifiers=)
    end
  end

  describe "#initialize" do
    it "should raise an exception if an invalid type of interface is given" do
      interface_stub = stub()
      interface_stub.should_receive(:is_a?).with(NXT::Interface::Base).once.and_return(false)
      expect do
        NXTRunner.new(interface_stub)
      end.to raise_exception(InvalidInterfaceError)
    end

    it "should set the interface to the incomming argument" do
      subject.interface.should equal(@interface)
    end

    it "should set the options to the incomming argument" do
      options_stub = stub()
      nxt = NXTRunner.new(@interface, options_stub)
      nxt.options.should equal(options_stub)
    end

    it "should call yield if given a block, passing self" do
      block_called = false

      NXTRunner.new(@interface) do |nxt|
        block_called = true
        nxt.should be_an_instance_of(NXTRunner)
      end

      block_called.should be_true
    end
  end

  describe "#add" do
    it "should raise an exception if an invalid type of port is given" do
      expect do
        subject.add("not a symbol", :symbol, Class)
      end.to raise_exception(TypeError, "Expected port to be a Symbol")
    end

    it "should raise an exception if an invalid type of identifier is given" do
      expect do
        subject.add(:symbol, "not a symbol", Class)
      end.to raise_exception(TypeError, "Expected identifier to be a Symbol")
    end

    it "should raise an exception if an invalid type of klass is given" do
      expect do
        subject.add(:symbol, :symbol, "not a class")
      end.to raise_exception(TypeError, "Expected klass to be a Class")
    end

    it "should raise an exception if an invalid port number or letter is given" do
      expect do
        subject.add(:invalid_port, :symbol, Class)
      end.to raise_exception(TypeError, "Expected port to be one of: :a, :b, :c, :one, :two, :three, :four")
    end

    it "should create a new instance of the passed klass and store it in the attribute for the given port" do
      port = :a
      class_stub = Class.new
      class_return_stub = stub()

      class_stub.should_receive(:new) do
        class_return_stub
      end.with(port).once()

      subject.add(port, :hello, class_stub)

      subject.send(port).should equal(class_return_stub)
    end
  end
end
