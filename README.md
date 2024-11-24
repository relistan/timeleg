timeleg
=======

A recursive-descent parser generated by Ian Piumarta's
[pegleg](https://www.piumarta.com/software/peg/) tool. This parser takes in a
large number of date formats and attempts to parse them.

The parser is written in C and is generated from `times.leg` using pegleg.
Currently it just prints out the parsed date.

The supported formats are found in [dateformats.txt](dateformats.txt).

## Building

To build the parser, you need to have pegleg installed. You can get it from
[here](https://www.piumarta.com/software/peg/). Once you have pegleg installed,
you can build the parser by running `make build`.

## Tests

Tests are run using the `test.sh` script. Normally you simply invoke:

```
make
```

This will both build and run the tests.

## Debugging

Debugging is enabled by uncommenting the `#define YY_DEBUG 1` line in `times.leg`.
