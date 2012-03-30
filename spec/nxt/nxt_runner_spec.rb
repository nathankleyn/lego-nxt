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
end
