ruby '2.5.0'
source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.6'

gem 'browser'
gem 'devise'
gem 'fast_blank'
gem 'httparty'
gem 'nokogiri'
gem 'oj'
gem 'pg', '~> 1.0'
gem 'pg_query', '>= 0.9.0'
gem 'pghero'
gem 'puma', '~> 3.12'
gem 'rack-cors'
gem 'sass-rails', '~> 5.0'
gem 'sentry-raven'
gem 'sidekiq', '< 6'
gem 'skylight'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data'
gem 'webpacker'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'faker'
  gem 'hirb'
  gem 'pry-byebug', require: false
  gem 'pry-clipboard'
  gem 'pry-rails'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'pry-state'
end

group :development do
  gem 'brakeman', require: false
  gem 'bullet'
  gem 'fast_stack' # profiling
  gem 'flamegraph' # profiling
  gem 'guard-bundler', require: false
  # gem 'guard-rspec', require: false
  gem 'guard-rubocop'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'memory_profiler' # profiling
  gem 'pronto'
  gem 'pronto-fasterer', require: false
  gem 'pronto-flay', require: false
  gem 'pronto-reek', require: false
  gem 'pronto-rubocop', require: false
  gem 'rack-mini-profiler'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'stackprof' # profiling
  gem 'web-console', '>= 3.3.0'
  gem 'yard'
end

group :test do
  gem 'coveralls', require: false
  gem 'fakeredis', require: 'fakeredis/rspec'
  # gem 'mutant-rspec' Waiting on version bump
  gem 'rspec-benchmark'
  gem 'rspec-rails', '~> 3.7'
  gem 'rspec-sidekiq'
  gem 'webmock'
end
