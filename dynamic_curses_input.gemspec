# frozen_string_literal: true

require_relative 'lib/dynamic_curses_input/version'

Gem::Specification.new do |spec|
  spec.name = 'dynamic_curses_input'
  spec.version = DynamicCursesInput::VERSION
  spec.authors = ['VetheonGames']
  spec.email = ['vetheon@pixelatedstudios.net']

  spec.summary = 'A simple library for making Curses TUI input more dynamic and user-friendly'
  spec.description = "Dynamic Curses Input is a highly simple, yet powerful gem that allows simple implementation of
                      dynamic typing in curses TUI menus built in Ruby. For example, one can't simply use their arrow
                      keys to navigate and edit inputs in Cursese TUI menus without adding a bunch of extra code to your
                      project to handle it. A lot of which can be tricky to handle. This gem eliminates the need for
                      that code, by providing simple to use methods that allow developers to capture user input, while
                      allowing the special keys to work as the average user would expect.
                      IE: When you press the left arrow key, the cursor moves to the left and allows you to delete a
                      character you entered that isn't the last character you entered."
  spec.homepage = 'https://github.com/Pixelated-Studios/dynamic_curses_input'
  spec.license = 'MIT'
  spec.required_ruby_version = '3.2.2'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/Pixelated-Studios/dynamic_curses_input'
  spec.metadata['changelog_uri'] = 'https://github.com/Pixelated-Studios/dynamic_curses_input/blob/main/CHANGELOG.md'

  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.glob('{bin,lib,sig}/**/*') + Dir.glob('*').reject { |f| f.start_with?('spec', '.rspec', 'dynamic_curses_input.gemspec') }
  spec.files << 'LICENSE.txt'
  spec.files << 'README.md'
  spec.files << 'dynamic_curses_input.gemspec'

  spec.require_paths = ['lib']

  spec.add_dependency 'curses'
  spec.add_dependency 'reline'
  spec.add_development_dependency 'rubocop'
end
