require 'spec_helper'

describe NXT::Connector::Output::Motor do
  before do
    @port = :a
    @interface = nil
  end

  subject do
    NXT::Connector::Output::Motor.new(@port, @interface)
  end

  describe 'constants' do
    it 'should have a DURATION_TYPE constant' do
      should have_constant(:DURATION_TYPE)
    end

    it 'should have a DURATION_AFTER constant' do
      should have_constant(:DURATION_AFTER)
    end

    it 'should have a DIRECTION constant' do
      should have_constant(:DIRECTION)
    end
  end

  describe 'accessors' do
    it 'should have read/write accessor for @port' do
      should respond_to(:port)
      should respond_to(:port=)
    end

    it 'should have read/write accessor for @interface' do
      should respond_to(:interface)
      should respond_to(:interface=)
    end
  end

  describe '#initialize' do
    it 'should set the port to the incomming argument' do
      expect(subject.port).to equal(@port)
    end

    it 'should set the interface to the incomming argument' do
      expect(subject.interface).to equal(@interface)
    end
  end
end
