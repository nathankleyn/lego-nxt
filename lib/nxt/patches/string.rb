class String
  def to_hex_str
    str = ""
    self.each_byte {|b| str << "0x%02x " % b}
    str
  end

  def from_hex_str_two
    data = self.split(" ")
    str = ""
    data.each {|h| eval "str += '%c' % #{h}"}
    str
  end

  def from_hex_str
    data = self.split(" ")
    str = ""

    data.each do |h|
      str += "%c" % h
    end

    str
  end
end
