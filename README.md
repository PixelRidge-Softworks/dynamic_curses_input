# DynamicCursesInput

DynamicCursesInput is a Ruby gem that provides a simple and intuitive way to handle user input in a Curses-based terminal user interface (TUI). It allows for dynamic input handling, including cursor movement and inline character addition and deletion.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Documentation](#documentation)
- [Dependencies](#dependencies)
- [FAQs](#faqs)
- [Troubleshooting](#troubleshooting)
- [Contribution Guidelines](#contribution-guidelines)
- [License](#license)

## Installation

To install DynamicCursesInput, add the following line to your application's Gemfile:

```ruby
gem 'dynamic_curses_input'
```

Then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install dynamic_curses_input
```

## Usage

Here's a simple example of how to use DynamicCursesInput:

```ruby
require "curses"
require "dynamic_curses_input"

begin
  Curses.init_screen
  Curses.start_color
  Curses.addstr("You should be able to use the left and right arrow keys to switch between characters in the line, and selectively edit them.\n")
  Curses.addstr("Enter your name: ")
  name = DCI.catch_input(true)
  Curses.addstr("\nYou entered: #{name}")
  Curses.getch

  # Log the output
  logger.info("Name entered: #{name}")
ensure
  Curses.close_screen
end
```

In this example, `DCI.catch_input(true)` will capture user input until the Enter key is pressed, echoing the input to the screen.

## Documentation

Detailed documentation for each function is available in the [wiki](https://github.com/Pixelated-Studios/dynamic_curses_input/wiki).

## Dependencies

DynamicCursesInput depends on the [Curses](https://github.com/ruby/curses) gem.

## FAQs

- **Q: How do I handle special keys like arrow keys?**
  - A: Special keys like arrow keys are automatically handled by DynamicCursesInput.

## Troubleshooting

If you encounter any issues while using DynamicCursesInput, please check the [issues](https://github.com/yourusername/dynamic_curses_input/issues) page. If your issue isn't listed, feel free to open a new issue.

## Contribution Guidelines

We welcome contributions from the community! Please read our [contribution guidelines](CONTRIBUTING.md) before submitting a pull request.

## License

DynamicCursesInput is available under the [MIT License](LICENSE.txt).

---

### Note from the Developer: 

There is a function in this gem that is not finished yet, it's for making asking questions in a Curses TUI easier from within the gem. This method shouldn't be used yet.
