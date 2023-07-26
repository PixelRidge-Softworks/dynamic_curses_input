# frozen_string_literal: true

# lib/dynamic_curses_input/color_window.rb

require 'curses'
require_relative 'input_handler'

module DynamicCursesInput
  # Class for creating a colored window
  class ColorWindow
    # Initialize instance variables and setup curses
    def initialize(echo, x, y)
      @echo = echo # Determines whether input should be echoed to the screen
      setup_curses_color # Setup curses
      @x = x
      @y = y
      # Define color pairs
      Curses.init_pair(1, Curses::COLOR_BLACK, Curses::COLOR_BLACK)
      Curses.init_pair(2, Curses::COLOR_BLUE, Curses::COLOR_BLACK)
      Curses.init_pair(3, Curses::COLOR_GREEN, Curses::COLOR_BLACK)
      Curses.init_pair(4, Curses::COLOR_CYAN, Curses::COLOR_BLACK)
      Curses.init_pair(5, Curses::COLOR_RED, Curses::COLOR_BLACK)
      Curses.init_pair(6, Curses::COLOR_MAGENTA, Curses::COLOR_BLACK)
      Curses.init_pair(7, Curses::COLOR_YELLOW, Curses::COLOR_BLACK) # Brown is usually represented as yellow
      Curses.init_pair(8, Curses::COLOR_WHITE, Curses::COLOR_BLACK)
    end

    # Method that adds colored text to the window
    def add_color_window(color, text, x, y, input: nil, echo: true)
      # Map color names to color pair numbers
      color_map = {
        'black' => 1,
        'blue' => 2,
        'green' => 3,
        'cyan' => 4,
        'red' => 5,
        'magenta' => 6,
        'brown' => 7, # Brown is usually represented as yellow in terminal colors
        'white' => 8
      }

      # Get the color pair number for the specified color
      color_pair = color_map[color.downcase]

      # Set the cursor position if both x and y are specified
      if x && y
        set_position(y, x)
      elsif x.nil? && y.nil?
        # If both x and y are not specified, raise an ArgumentError
        raise ArgumentError, 'Both x and y coordinates must be specified for printing the color window.'
      end

      # Print the text in the specified color
      Curses.attron(Curses.color_pair(color_pair))
      Curses.addstr(text)
      Curses.attroff(Curses.color_pair(color_pair))

      # If an input is specified, take input from the user
      InputHandler.catch_input(echo) if input

      Curses.refresh
    end

    private

    # Setup curses
    def setup_curses_color
      Curses.init_screen
      Curses.start_color
    end

    # Set cursor position manually on the X and Y axis
    def set_position(y, x)
      Curses.setpos(y, x)
    end
  end
end
