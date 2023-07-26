# frozen_string_literal: true

# lib/dynamic_curses_input.rb

require 'readline' # Add the Readline module
require_relative 'dynamic_curses_input/version'
require_relative 'dynamic_curses_input/input_handler'
require_relative 'dynamic_curses_input/color_window'

# The module entrypoint for our Gem
module DynamicCursesInput
  class Error < StandardError; end

  def self.catch_input(echo)
    InputHandler.catch_input(echo)
  end

  def self.ask_question(color = 'white', question, x: 'center', input: true, echo: nil)
    Curses.clear
    ColorWindow.add_color_window(color, question, y:, x:, input:, echo:)
  end

  def self.print_color_window(color, text, y_value: nil, x: 'center', input: nil, echo: true)
    case x
    when 'center'
      terminal_size = `stty size`.split.map(&:to_i)
      y_value = terminal_size[0] / 2
      x_value = terminal_size[1] / 2 - text.length / 2 # Adjust x-coordinate to center the window
      x_value -= 12 if x_value > 1
      # the above line shifts the X value of the cell coords back by 12 cells if we are trying to center the window
      # we have to do this because math gets kind of approximate when we convert pixel ratios to character cell coords
    when 'left'
      y_value = Curses.lines / 2
      x_value = 0
    when 'right'
      y_value = Curses.lines / 2
      x_value = Curses.cols - text.length
    when 'left_center'
      y_value = Curses.lines / 4
      x_value = 0
    when 'right_center'
      y_value = Curses.lines / 4
      x_value = Curses.cols - text.length
    else
      y_value, x_value = x.split('px').map(&:to_i)
    end

    # Initialize curses and get the terminal size
    Curses.init_screen
    Curses.start_color
    Curses.refresh

    # Set up Readline for proper terminal settings
    setup_readline

    ColorWindow.new(echo, x_value, y_value).add_color_window(color, text, x_value, y_value, input:, echo:)
  end

  class << self
    private

    def process_print_color_window_args(args)
      case args.size
      when 2
        ['white', args[0], args[1], 'center', nil, true]
      when 3
        ['white', args[0], args[1], args[2], nil, true]
      when 4
        ['white', args[0], args[1], args[2], args[3], true]
      when 5
        [args[0], args[1], args[2], args[3], args[4]]
      else
        raise ArgumentError, 'print_color_window accepts 2 to 5 arguments: color, text, [position], [input], [echo]'
      end
    end
  end

  def self.setup_readline
    # Set up Readline for proper terminal settings
    Readline.emacs_editing_mode
    # the above line sets Readline to emacs_editing_mode so that terminals behave like they're supposed to
    Readline.completion_append_character = ' '
    # we remove Readlines thing where it adds a space to the end of tab completes because it breaks the Curses cursor
    Readline.completion_proc = proc { |_s| [] }
    # here we basically are disabling tab completion all together. That's because for some reason it breaks the cursor
  end
end

DCI = DynamicCursesInput
