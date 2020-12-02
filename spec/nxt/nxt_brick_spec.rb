# frozen_string_literal: true

require 'spec_helper'

describe NXTBrick do
  subject(:nxt_brick) { described_class.new(:usb) }

  describe 'accessors' do
    it 'has a read accessor for @interface' do
      expect(nxt_brick).to respond_to(:interface)
    end

    it 'has write accessor for @interface' do
      expect(nxt_brick).to respond_to(:interface=)
    end

    it 'has a read accessor for @a' do
      expect(nxt_brick).to respond_to(:a)
    end

    it 'has a write accessor for @a' do
      expect(nxt_brick).not_to respond_to(:a=)
    end

    it 'has a read accessor for @b' do
      expect(nxt_brick).to respond_to(:b)
    end

    it 'has a write accessor for @b' do
      expect(nxt_brick).not_to respond_to(:b=)
    end

    it 'has a read accessor for @c' do
      expect(nxt_brick).to respond_to(:c)
    end

    it 'has a write accessor for @c' do
      expect(nxt_brick).not_to respond_to(:c=)
    end

    it 'has a read accessor for @one' do
      expect(nxt_brick).to respond_to(:one)
    end

    it 'has a write accessor for @one' do
      expect(nxt_brick).not_to respond_to(:one=)
    end

    it 'has a read accessor for @two' do
      expect(nxt_brick).to respond_to(:two)
    end

    it 'has a write accessor for @two' do
      expect(nxt_brick).not_to respond_to(:two=)
    end

    it 'has a read accessor for @three' do
      expect(nxt_brick).to respond_to(:three)
    end

    it 'has a write accessor for @three' do
      expect(nxt_brick).not_to respond_to(:three=)
    end

    it 'has a read accessor for @four' do
      expect(nxt_brick).to respond_to(:four)
    end

    it 'has a write accessor for @four' do
      expect(nxt_brick).not_to respond_to(:four=)
    end

    it 'has a read accessor for @port_identifiers' do
      expect(nxt_brick).to respond_to(:port_identifiers)
    end

    it 'has a write accessor for @port_identifiers' do
      expect(nxt_brick).not_to respond_to(:port_identifiers=)
    end
  end

  describe '#initialize' do
    it 'raises an exception if an invalid type of interface is given' do
      expect do
        described_class.new(:foobar)
      end.to raise_exception(InvalidInterfaceError)
    end

    it 'sets the interface to the incomming argument' do
      expect(nxt_brick.interface).to be_an_instance_of(NXT::Interface::Usb)
    end

    it 'calls yield if given a block, passing self' do
      block_called = false

      # rubocop:disable RSpec/AnyInstance
      allow_any_instance_of(NXT::Interface::Usb).to receive(:connect)
      # rubocop:enable RSpec/AnyInstance

      described_class.new(:usb) do |_nxt|
        block_called = true
      end

      expect(block_called).to be true
    end

    it 'passes self if given a block' do
      # rubocop:disable RSpec/AnyInstance
      allow_any_instance_of(NXT::Interface::Usb).to receive(:connect)
      # rubocop:enable RSpec/AnyInstance

      described_class.new(:usb) do |nxt|
        expect(nxt).to be_an_instance_of(described_class)
      end
    end
  end

  describe '#connect' do
    let(:interface) { Object.new }

    before do
      nxt_brick.instance_variable_set(:@interface, interface)
    end

    it 'calls connect on the interface' do
      allow(interface).to receive(:connect)

      nxt_brick.connect

      expect(interface).to have_received(:connect)
    end
  end

  describe '#disconnect' do
    let(:interface) { Object.new }

    before do
      nxt_brick.instance_variable_set(:@interface, interface)
    end

    it 'calls disconnect on the interface' do
      allow(interface).to receive(:disconnect)

      nxt_brick.disconnect

      expect(interface).to have_received(:disconnect)
    end
  end

  describe '#add' do
    let(:port) { :a }
    let(:identifier) { :hello }
    let(:class_stub) do
      Class.new do
        def initialize(*_args)
          nil
        end
      end
    end

    it 'raises an exception if an invalid port number or letter is given' do
      expect do
        nxt_brick.add(:invalid_port, identifier, class_stub)
      end.to raise_exception(TypeError, 'Expected port to be one of: :a, :b, :c, :one, :two, :three, :four')
    end

    it 'raises an exception if an invalid type of identifier is given' do
      expect do
        nxt_brick.add(port, 123, class_stub)
      end.to raise_exception(TypeError, 'Expected identifier to respond to: to_sym')
    end

    it 'raises an exception if an invalid type of class is given' do
      expect do
        nxt_brick.add(port, identifier, 'not a class')
      end.to raise_exception(TypeError, 'Expected klass to be of type Class')
    end

    it 'raises an exception if trying to use an identifier that is the name of a defined method' do
      expect do
        nxt_brick.add(port, :add, class_stub)
      end.to raise_error(
        InvalidIdentifierError,
        'Cannot use identifier add, a method on NXTBrick is already using it.'
      )
    end

    it 'raises an exception if the port given is already set' do
      nxt_brick.add(port, identifier, class_stub)

      expect do
        nxt_brick.add(port, identifier, class_stub)
      end.to raise_error(PortTakenError, "Port #{port} is already set, call remove first")
    end

    it 'sets up the port if the given port is not alread in use' do
      nxt_brick.add(port, identifier, class_stub)

      expect(nxt_brick.send(port)).not_to eq(nil)
    end
  end

  describe '#remove' do
    it 'raises an exception if an invalid type of identifier is given' do
      expect do
        nxt_brick.remove(123)
      end.to raise_exception(TypeError, 'Expected identifier to respond to: to_sym')
    end

    it 'removes any matching identifiers' do
      identifier = :hello_world
      port_identifiers = {}
      nxt_brick.instance_variable_set(:@port_identifiers, port_identifiers)

      allow(port_identifiers).to receive(:delete)

      nxt_brick.remove(identifier)

      expect(port_identifiers).to have_received(:delete).with(identifier).once
    end

    it 'returns a boolean true if it removed anything' do
      identifier = :hello_world
      port_identifiers = {}
      port_identifiers[identifier] = true
      nxt_brick.instance_variable_set(:@port_identifiers, port_identifiers)

      return_value = nxt_brick.remove(identifier)
      expect(return_value).to be true
    end

    it 'removes the port if it did delete something' do
      identifier = :hello_world
      port_identifiers = {}
      port_identifiers[identifier] = true
      nxt_brick.instance_variable_set(:@port_identifiers, port_identifiers)

      nxt_brick.remove(identifier)

      expect(port_identifiers).not_to include(identifier)
    end

    it 'returns a boolean false if it did not remove anything' do
      return_value = nxt_brick.remove(:hello_world)
      expect(return_value).to be false
    end
  end

  describe '#define_port_handler_method' do
    let(:port) { :a }
    let(:identifier) { :hello }
    let(:class_stub) do
      Class.new do
        def initialize(*_args)
          nil
        end
      end
    end

    it 'stores it in the attribute for the given port' do
      class_return_stub = double
      allow(class_stub).to receive(:new) { class_return_stub }

      nxt_brick.send(:define_port_handler_method, port, identifier, class_stub)

      expect(nxt_brick.send(port)).to equal(class_return_stub)
    end

    it 'sets up the port identifiers correctly' do
      nxt_brick.send(:define_port_handler_method, port, identifier, class_stub)
      expect(nxt_brick.port_identifiers[identifier]).to equal(port)
    end
  end
end
