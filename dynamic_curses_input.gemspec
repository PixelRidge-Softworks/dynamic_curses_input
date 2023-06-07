# frozen_string_literal: true

require_relative "lib/dynamic_curses_input/version"

Gem::Specification.new do |spec|
  spec.name = "dynamic_curses_input"
  spec.version = DynamicCursesInput::VERSION
  spec.authors = ["VetheonGames"]
  spec.email = ["vetheon@pixelatedstudios.net"]

  spec.summary = "A simple library for making Curses TUI input more dynamic and user-friendly"
  spec.description = "Dynamic Curses Input is a highly simple, yet powerful gem that allows simple implementation of dynamic typing in curses TUI menus built in Ruby. For example, one can't simply use their arrow keys to navigate and edit inputs in Cursese TUI menus without adding a bunch of extra code to your project to handle it. A lot of which can be tricky to handle. This gem eliminates the need for that code, by providing simple to use methods that allow developers to capture user input, while allowing the special keys to work as the average user would expect. IE: When you press the left arrow key, the cursor moves to the left and allows you to delete a character you entered that isn't the last character you entered."
  spec.homepage = "https://github.com/Pixelated-Studios/dynamic_curses_input"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Pixelated-Studios/dynamic_curses_input"
  spec.metadata["changelog_uri"] = "https://github.com/Pixelated-Studios/dynamic_curses_input/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "curses"
end
