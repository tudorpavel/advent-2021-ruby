# Advent of Code 2021 - Ruby

Solving [Advent of Code 2021](https://adventofcode.com/2021) using Ruby with Sorbet type checking and RSpec unit testing.

After Setup, to run a particular day run:

```
ruby day01/main.rb < day01/input.txt
```

## Setup

Ruby version used:

```
asdf install ruby 2.7.5
```

Update bundler:

```
gem install bundler:2.2.32
```

Install dependencies:
```
bundle install
```

## Development checks

Run tests with:

```
bundle exec rspec
```

Check coding style with:

```
bundle exec rubocop
```

Run type checker:

```
bundle exec srb tc
```
