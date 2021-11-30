# typed: strict
# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

gem 'sorbet-runtime'

group :development do
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'solargraph'
  gem 'sorbet'
end

group :development, :test do
  gem 'rspec'
end
