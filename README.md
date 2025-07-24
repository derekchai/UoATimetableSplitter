# UoA Timetable Splitter
This is a simple command-line program which splits an `ics` calendaring file 
obtained from the University of Auckland 
[My Timetable tool](https://mytimetable.auckland.ac.nz) into separate 
sub-calendars (each with their own `ics` file) by subject/course.

This may be useful for importing into external calendaring software (e.g. Apple
Calendar) and allows the assignment of unique colours to each course's calendar,
etc. UoA Timetable Splitter also displays the class location in the location
field of events (rather than in the description, as it is from My Timetable).

## Disclaimer
This program is not affiliated with or approved by the University of Auckland.

# Installation
## Executable
Download the `exe` file from this repository's
[Releases](https://github.com/derekchai/UoATimetableSplitter/releases) page. 

## Compile
The source code for the project is available at this repository to be compiled
manually.

# Usage
```
UoATimetableSplitter <file-path> [--output-path <output-path>]
```

Run `UoATimetableSplitter` with flag `-h` for help.

# Example
To split the `ics` file `my_calendar.ics`:

1. Run `./UoATimetableSplitter my_calendar.ics`

By default, the output files will be output in the current directory. Use the
`--output-path` option to specify an alternative directory.
