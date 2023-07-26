## [Release]

## [1.0.0] - 2023-06-07

- Initial release

## [Release]

## [1.1.0] - 2023-07-26

- Features and Enhancements:

    - Added support for printing colored windows with customized positions and color schemes.
    - Introduced the DynamicCursesInput::ColorWindow class, which allows creating colored text windows within the terminal.
    - The ColorWindow class provides methods to add colored text to the window and handle user input.
    - Implemented automatic centering of text within the window when x is set to 'center'.
    - Adjusted the centered position to shift back by 12 cells for better visual layout when necessary.
    - Removed reliance on Fibers and replaced it with instance methods to resolve issues with positioning.
    - Handled compatibility issues with different terminal environments to ensure consistent behavior.
    - Refactored the code to eliminate unnecessary checks for IRB, enabling smooth execution in various contexts.
    - Improved the debug log functionality for easier debugging and troubleshooting.

- Bug Fixes:

    - Fixed the issue causing text to be misaligned or misplaced in certain terminal environments.
    - Resolved a bug where the window position was not being updated correctly in some cases.

- Other Changes:

    - Removed redundant and unused code snippets to improve code cleanliness and maintainability.
