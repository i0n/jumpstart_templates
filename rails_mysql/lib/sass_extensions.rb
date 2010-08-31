module Sass::Script::Functions
  
  # Converts a number into an integer (Useful for converting percentages etc)
  def integer(number)
    assert_type number, :Number
    Sass::Script::Number.new(number.to_i)
  end
  
end