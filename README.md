[![Build Status](https://travis-ci.org/AshleyByeUK/tictactoe-ruby-json-api.svg?branch=master)](https://travis-ci.org/AshleyByeUK/tictactoe-ruby-json-api)
[![codecov](https://codecov.io/gh/AshleyByeUK/tictactoe-ruby-json-api/branch/master/graph/badge.svg)](https://codecov.io/gh/AshleyByeUK/tictactoe-ruby-json-api)

# tictactoe-ruby-json-api

A JSON API for the game of [TictacToe](https://github.com/AshleyByeUK/tictactoe-ruby-core).

## Requirements

The game depends on Ruby version 2.5.2 or greater. It has not been tested against earlier versions. Testing
has only been carried out on macOS.

## Downloading

To download the source, clone the repository:

```
git clone git@github.com:AshleyByeUK/tictactoe-ruby-json-api.git
cd tictactoe-ruby-json-api
bundle install
```

All of the following commands assume the current working directory is `tictactoe-ruby-json-api`.

## JSON API

To run the JSON API, execute:

```
bundle exec rackup
```

## Testing

Running the tests:

```
bundle exec rspec
```

Or:

```
bundle exec rspec --format doc
```

Once `rspec` has run, you can view the code coverage report in your web browser:

```
open ./coverage/index.html
```
