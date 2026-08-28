source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '>= 4.0.0', '< 4.1.0'

gem 'rails', '8.1.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 7.2'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bcrypt', '~> 3.1.20'
gem 'bootsnap', '>= 1.4.2', require: false

gem 'rails-i18n', '~> 8.1.0'
gem 'kaminari'

group :development, :test do
  gem 'byebug', platforms: [:mri, :windows]
  gem 'rspec-rails'
  gem 'rexml'
  gem 'factory_bot_rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.1'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver', '4.47.0'
end

gem 'tzinfo-data', platforms: [:windows, :jruby]