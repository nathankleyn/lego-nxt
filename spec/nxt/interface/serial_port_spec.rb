# frozen_string_literal: true

require 'spec_helper'

describe NXT::Interface::SerialPort do
  subject(:serial_port) { described_class.new(device) }

  let(:device) { '/dev/zero' }

  describe 'constants' do
    it 'has a BAUD_RATE constant' do
      expect(serial_port).to have_constant(:BAUD_RATE)
    end

    it 'has a DATA_BITS constant' do
      expect(serial_port).to have_constant(:DATA_BITS)
    end

    it 'has a STOP_BITS constant' do
      expect(serial_port).to have_constant(:STOP_BITS)
    end

    it 'has a PARITY constant' do
      expect(serial_port).to have_constant(:PARITY)
    end

    it 'has a READ_TIMEOUT constant' do
      expect(serial_port).to have_constant(:READ_TIMEOUT)
    end
  end

  describe 'accessors' do
    it 'has read accessor for @dev' do
      expect(serial_port).to respond_to(:dev)
    end

    it 'has write accessor for @dev' do
      expect(serial_port).to respond_to(:dev=)
    end
  end

  describe '#initialize' do
    it 'sets the device to the incomming argument' do
      expect(serial_port.dev).to equal(device)
    end

    it 'raises an exception when trying to connect to invalid dev files' do
      expect do
        serial_port.class.new('/dev/foobar')
      end.to raise_exception(InvalidDeviceError)
    end
  end

  describe '#connect' do
    it 'raises an exception when the SerialPort connection failed' do
      expect do
        serial_port.connect
      end.to raise_exception(SerialPortConnectionError, "The #{device} device is not a valid SerialPort")
    end

    it 'raises an exception when the SerialPort connection is nil' do
      allow(::SerialPort).to receive(:new).and_return(nil)
      expect do
        serial_port.connect
      end.to raise_exception(SerialPortConnectionError, "Could not establish a SerialPort connection to #{device}")
    end

    it 'sets the flow control and read timeout when the connection is established' do
      serial_port_stub = double
      allow(serial_port_stub).to receive(:flow_control=).with(::SerialPort::HARD).once
      allow(serial_port_stub).to receive(:read_timeout=).with(serial_port.class::READ_TIMEOUT).once
      allow(::SerialPort).to receive(:new).and_return(serial_port_stub)

      serial_port.connect
    end
  end

  describe '#disconnect' do
    let(:connection_klass) do
      Class.new do
        def initialize(closed)
          @closed = closed
        end

        def closed?
          @closed
        end
      end
    end

    it 'closes the connection if connected' do
      connection = connection_klass.new(false)
      allow(connection).to receive(:close)
      serial_port.instance_variable_set(:@connection, connection)

      serial_port.disconnect

      expect(connection).to have_received(:close)
    end

    it 'does not close the connection if already disconnected' do
      connection = connection_klass.new(true)
      allow(connection).to receive(:close)
      serial_port.instance_variable_set(:@connection, connection)

      serial_port.disconnect

      expect(connection).not_to have_received(:close)
    end
  end

  # describe '#send' do

  # end

  # describe '#receive' do

  # end
end
