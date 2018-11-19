[![Build Status](https://travis-ci.org/AshleyByeUK/tictactoe-ruby.svg?branch=master)](https://travis-ci.org/AshleyByeUK/tictactoe-ruby)
[![codecov](https://codecov.io/gh/AshleyByeUK/tictactoe-ruby/branch/master/graph/badge.svg)](https://codecov.io/gh/AshleyByeUK/tictactoe-ruby)

# TicTacToe (Ruby Edtion)

The venerable game of TicTacToe, written in Ruby, otherwise known as noughts and crosses. Game player types
include Human, Easy Computer and Hard Computer. Games can be played on either a 3x3 or a 4x4 board.

## Requirements

The game depends on Ruby version 2.5.2 or greater. It has not been tested against earlier versions. Testing
has only been carried out on macOS.

## Downloading

To download the source, clone the repository:

```
git clone git@github.com:AshleyByeUK/tictactoe-ruby.git
cd tictactoe-ruby
```

All of the following commands assume the current working directory is `tictactoe-ruby`.

## Playing

Run the game (executable from anywhere - add the `bin` directory to your `PATH` if you want):

```
bin/tictactoe
```

## JSON API

To run the JSON API, execute:

```
bundle exec rackup
```

## Testing

Running the tests:

```
bundle install
bundle exec rspec
```

Or:

```
bundle install
bundle exec rspec --format doc
```

Once `rspec` has run, you can view the code coverage report in your web browser:

```
open ./coverage/index.html
```
