# hexe.rb
# made by nilsding in 2014
# license: MIT
#
# ASCII art is not mine, it was made by someone who names himself "ns", found
# this on http://ascii.co.uk/art/witch

require 'hexe/version'
require 'io/console'

class Hexe
  def initialize
    # The witch.  Art by "ns", found on http://ascii.co.uk/art/witch
    @witch = [
        '                /\\',
        '              _/__\\_',
        '              /( o\\',
        '          /|  // \\-\'',
        '    __  ( o,    /\\',
        '      ) / |    / _\\',
        '>>>>==(_(__u---(___ )-----',
        '                  //',
        '                /__)'
      ]
    @witch_width = @witch.group_by.max.length
    @witch_height = @witch.length
    @height, @width = $stdout.winsize
  end

  # Moves the cursor up +@witch_height+ lines.
  def move_to_top
    $stdout.write "\033[#{@witch_height}A"
  end

  # Moves the x position of the cursor to +x+.
  # @param x [Integer] The position to move the cursor to.
  def move_to_x(x)
    $stdout.write "\033[#{x}C"
  end

  # Prints a string starting at x position +start_x+.  If the string is longer
  # than the terminal width, it gets trimmed.
  # @param start_x [Integer] Starting x position
  # @param str [String] The string to be printed
  def line_at(start_x, str)
    x = start_x
    move_to_x(start_x) if start_x > 1
    str.length.times do |i|
      $stdout.putc str[i] if x > 0 && x < @width
      x += 1
    end
    $stdout.putc "\n"
  end
  
  # Draws the witch at x position +x+.
  # @param x [Integer] The x position to draw the witch
  def draw_witch(x)
    move_to_top
    @witch.each do |line|
      line_at x, line
    end
  end
  
  # Clears the first two characters at position +x+.
  # @param x [Integer] The x position to start clearing from
  def clear_witch(x)
    move_to_top
    @witch_height.times do
      line_at x, "  "
    end
  end
  
  # Witchcraft!
  def hex_hex!
    wait_time = ((rand() * 100) % 60 + 20) / 1000
    (@witch_height + 1).times { $stdout.write "\n" }
    (-@witch_width..@width).each do |x|
      draw_witch x
      sleep wait_time
      clear_witch(x)
    end
    move_to_top
    puts ";-)"
  end
end
