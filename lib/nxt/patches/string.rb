# frozen_string_literal: true

# Some patches that extend the default Ruby String class with some useful
# methods.
class String
  # Convert the given string to a hexadecimal representation of the same data.
  # This method is non-destructive, it will return a new copy of the string
  # convered to hex.
  def to_hex_str
    str = ''
    each_byte { |b| str << format('0x%02x ', b) }
    str
  end

  def from_hex_str
    unpack('C*')
  end
end
