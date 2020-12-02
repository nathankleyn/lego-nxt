# frozen_string_literal: true

require 'spec_helper'

describe NXT::Connector::Output::Motor do
  subject(:motor) { described_class.new(port, interface) }

  let(:port) { :a }
  let(:interface) { nil }

  describe 'constants' do
    it 'has a DURATION_TYPE constant' do
      expect(motor).to have_constant(:DURATION_TYPE)
    end

    it 'has a DURATION_AFTER constant' do
      expect(motor).to have_constant(:DURATION_AFTER)
    end

    it 'has a DIRECTION constant' do
      expect(motor).to have_constant(:DIRECTION)
    end
  end

  describe 'accessors' do
    it 'has read accessor for @port' do
      expect(motor).to respond_to(:port)
    end

    it 'has write accessor for @port' do
      expect(motor).to respond_to(:port=)
    end

    it 'has read accessor for @interface' do
      expect(motor).to respond_to(:interface)
    end

    it 'has write accessor for @interface' do
      expect(motor).to respond_to(:interface=)
    end
  end

  describe '#initialize' do
    it 'sets the port to the incomming argument' do
      expect(motor.port).to equal(port)
    end

    it 'sets the interface to the incomming argument' do
      expect(motor.interface).to equal(interface)
    end
  end
end
