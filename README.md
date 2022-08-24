# Advent of Code 2021 - Ruby

Solving [Advent of Code 2021](https://adventofcode.com/2021) using Ruby with Sorbet type checking and RSpec unit testing.

After Setup, to run a particular day run:

```
ruby day01/main.rb < day01/input.txt
```

## Setup

Ruby version used:

```
asdf install ruby 2.7.6
```

Update bundler:

```
gem install bundler:2.3.13
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

## Troubleshooting

If the Solargraph LSP gives warnings about 'required path could not be resolved' it's because Solargraph needs YARD docs to resolve dependencies. Following the [vscode-solargraph](https://github.com/castwide/vscode-solargraph#solargraph-and-bundler) instructions you need to run:

```
bundle exec yard gems
```
