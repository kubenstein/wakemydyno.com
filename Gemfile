source 'https://rubygems.org'

ruby '2.1.1'
gem 'rails', '3.2.19'


gem 'jquery-rails'
gem 'slim'
gem 'www-redirect'
gem 'httparty'
gem 'sentry-raven', github: 'getsentry/raven-ruby', ref: '8e63d48823a60b7d591932582b6e3ee3678fea60'

group :assets do
  gem 'sass-rails'
  gem 'uglifier'
  gem 'compass-rails'
end

group :test do
  gem 'test-unit'
  gem 'factory_girl_rails'
  gem 'fakeweb'
  gem 'timecop'
  gem 'simplecov', require: false
end

group :development do
  gem 'sqlite3'
  gem 'thin'
  gem 'rails-dev-tweaks'
  gem 'quiet_assets'
  gem 'annotate'
end

group :production do
  gem 'unicorn'
  gem 'pg', '0.17.1'
end
