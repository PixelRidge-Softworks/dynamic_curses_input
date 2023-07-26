# frozen_string_literal: true

# lib/dynamic_curses_input/input_handler.rb

require 'curses'

module DynamicCursesInput
  # our main class for handling input
  class InputHandler
    # Class method that initializes a new instance of InputHandler and calls the instance method catch_input
    def self.catch_input(echo)
      new(echo).catch_input
    end

    # Initialize instance variables and setup curses
    def initialize(echo)
      @echo = echo # Determines whether input should be echoed to the screen
      @input = '' # Stores the input string
      @cursor_pos = 0 # Stores the current cursor position
      @initial_y = Curses.stdscr.cury # Stores the initial y-coordinate of the cursor
      @initial_x = Curses.stdscr.curx # Stores the initial x-coordinate of the cursor
      setup_curses # Setup curses
    end

    # Main method that catches user input
    def catch_input
      # Loop until the user hits the enter key (represented by :break)
      while (chk = Curses.getch)
        break if handle_key(chk) == :break

        redraw_input # Redraw the input string
      end
      Curses.echo if @echo # Echo the input if @echo is true
      @input # Return the input string
    end

    private

    # Setup curses
    def setup_curses
      Curses.stdscr.keypad(true) # Enable keypad of the user's terminal
      Curses.noecho unless @echo # Don't echo the input if @echo is false
    end

    # Handle key press
    def handle_key(chk)
      case chk
      when Curses::KEY_LEFT then handle_left_key # Move cursor left
      when Curses::KEY_RIGHT then handle_right_key # Move cursor right
      when Curses::KEY_BACKSPACE, 127 then handle_backspace_key # Delete character
      when 10, 13 then handle_enter_key # Break loop if enter key is pressed
      else handle_default_key(chk) # Add character to input string
      end
    end

    # Move cursor left
    def handle_left_key
      @cursor_pos = CursorMover.left(@cursor_pos)
    end

    # Move cursor right
    def handle_right_key
      @cursor_pos = CursorMover.right(@cursor_pos, @input.length)
    end

    # Delete character
    def handle_backspace_key
      @input, @cursor_pos = CharacterDeleter.delete(@input, @cursor_pos)
    end

    # Break loop if enter key is pressed
    # This is a bit unconventional, but it's a simple way to break the loop from within the handle_key method
    def handle_enter_key
      :break
    end

    # Add character to input string
    def handle_default_key(chk)
      return unless chk.is_a?(String) && !chk.nil?

      @input, @cursor_pos = CharacterAdder.add(chk, @input, @cursor_pos)
    end

    # Redraw the input string
    def redraw_input
      Curses.setpos(@initial_y, @initial_x) # Move cursor to initial position
      Curses.addstr(' ' * (Curses.cols - @initial_x)) # Clear line
      Curses.setpos(@initial_y, @initial_x) # Move cursor to initial position
      Curses.addstr(@input) if @echo # Draw input string if @echo is true
      Curses.setpos(@initial_y, @initial_x + @cursor_pos) # Move cursor to current position
    end
  end

  # Class for moving the cursor
  class CursorMover
    # Move cursor left
    def self.left(cursor_pos)
      cursor_pos.zero? ? cursor_pos : cursor_pos - 1
    end

    # Move cursor right
    def self.right(cursor_pos, length)
      cursor_pos == length ? cursor_pos : cursor_pos + 1
    end

    # Set cursor position
    def self.set_position(y, x)
      Curses.setpos(y, x)
    end
  end

  # Class for deleting characters
  class CharacterDeleter
    # Delete character at cursor position
    def self.delete(input, cursor_pos)
      if cursor_pos.positive?
        input = input[0...cursor_pos - 1] + input[cursor_pos..]
        cursor_pos -= 1
      end
      [input, cursor_pos]
    end
  end

  # Class for adding characters
  class CharacterAdder
    # Add character at cursor position
    def self.add(chk, input, cursor_pos)
      input = input[0...cursor_pos] + chk + input[cursor_pos..]
      cursor_pos += 1
      [input, cursor_pos]
    end
  end
end
