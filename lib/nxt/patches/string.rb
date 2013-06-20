class String
  # Convert the given string to a hexadecimal representation of the same data.
  # This method is non-destructive, it will return a new copy of the string
  # convered to hex.
  def to_hex_str
    str = ''
    self.each_byte {|b| str << '0x%02x ' % b}
    str
  end

  #
  def from_hex_str_two
    data = self.split(' ')
    str = ''
    data.each {|h| eval "str += '%c' % #{h}"}
    str
  end

  def from_hex_str
    self.unpack('C*')
  end
end
