require 'spec_helper'

describe NXT::Interface::SerialPort do
  before do
    @device = '/dev/zero'
    @bad_device = 'hello world'
  end

  subject do
    NXT::Interface::SerialPort.new(@device)
  end

  describe 'constants' do
    it 'should have a BAUD_RATE constant' do
      should have_constant(:BAUD_RATE)
      should have_constant(:DATA_BITS)
      should have_constant(:STOP_BITS)
      should have_constant(:PARITY)
      should have_constant(:READ_TIMEOUT)
    end
  end

  describe 'accessors' do
    it 'should have read/write accessor for @dev' do
      should respond_to(:dev)
      should respond_to(:dev=)
    end
  end

  describe '#initialize' do
    it 'should set the device to the incomming argument' do
      subject.dev.should equal(@device)
    end

    it 'should raise an exception when trying to connect to invalid dev files' do
      expect do
        subject.class.new(@bad_device)
      end.to raise_exception(InvalidDeviceError)
    end
  end

  describe '#connect' do
    it 'should raise an exception when the SerialPort connection failed' do
      expect do
        subject.connect
      end.to raise_exception(SerialPortConnectionError, "The #{@device} device is not a valid SerialPort")
    end

    it 'should raise an exception when the SerialPort connection is nil' do
      ::SerialPort.should_receive(:new).and_return(nil)
      expect do
        subject.connect
      end.to raise_exception(SerialPortConnectionError, "Could not establish a SerialPort connection to #{@device}")
    end

    it 'should set the flow control and read timeout when the connection is established' do
      serial_port_stub = stub()
      serial_port_stub.should_receive(:flow_control=).with(::SerialPort::HARD).once
      serial_port_stub.should_receive(:read_timeout=).with(subject.class::READ_TIMEOUT).once
      ::SerialPort.should_receive(:new).and_return(serial_port_stub)

      subject.connect
    end
  end

  describe '#send' do

  end

  describe '#receive' do

  end
end
