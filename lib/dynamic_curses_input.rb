# frozen_string_literal: true

# lib/dynamic_curses_input.rb

require_relative "dynamic_curses_input/version"
require_relative "dynamic_curses_input/input_handler"

# The module entrypoint for our Gem
module DynamicCursesInput
  class Error < StandardError; end

  def self.catch_input(echo)
    InputHandler.catch_input(echo)
  end

  def self.ask_question(question, echo)
    Curses.clear
    Curses.setpos(1, 0)
    Curses.addstr(question)
    Curses.refresh
    catch_input(echo)
  end
end

DCI = DynamicCursesInput
