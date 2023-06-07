# frozen_string_literal: true

# lib/dynamic_curses_input/input_handler.rb

require "curses"

module DynamicCursesInput
  # our main class for actually handling our user input
  class InputHandler
    def self.catch_input(echo) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      Curses.stdscr.keypad(true)
      input = ""
      cursor_pos = 0
      initial_y = Curses.stdscr.cury
      initial_x = Curses.stdscr.curx
      Curses.noecho unless echo
      while (ch = Curses.getch)
        case ch
        when Curses::KEY_LEFT
          cursor_pos -= 1 unless cursor_pos.zero?
        when Curses::KEY_RIGHT
          cursor_pos += 1 unless cursor_pos == input.length
        when Curses::KEY_BACKSPACE, 127
          if cursor_pos.positive?
            input = input[0...cursor_pos - 1] + input[cursor_pos..]
            cursor_pos -= 1
          end
        when 10, 13
          break
        else
          if ch.is_a?(String) && !ch.nil?
            input = input[0...cursor_pos] + ch + input[cursor_pos..]
            cursor_pos += 1
          end
        end
        Curses.setpos(initial_y, initial_x)
        Curses.addstr(" " * (Curses.cols - initial_x))
        Curses.setpos(initial_y, initial_x)
        Curses.addstr(input) if echo
        Curses.setpos(initial_y, initial_x + cursor_pos)
      end
      Curses.echo if echo
      input
    end
  end
end
