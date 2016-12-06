# You should specify the ruby version
ruby "2.3.1"

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Processes
gem 'foreman'
gem 'sidekiq'

# Heroku suggests the rails_12factor gem, but this should only
# be used in production
group :production do
  gem 'rails_12factor'
end

# Kits
gem 'authkit', git: 'https://github.com/jeffrafter/authkit'
gem 'errorkit', git: 'https://github.com/jeffrafter/errorkit'
gem 'notifykit', git: 'https://github.com/jeffrafter/notifykit'
gem 'uikit', git: 'https://github.com/jeffrafter/uikit'

# These are a couple of my favs, if I forget them I regret it
gem 'strapless'
gem 'awesome_print'

# For particle
gem 'particlerb'

group :development, :test do
  # Keeping the database fields in the models and specs makes things easier
  gem 'annotate'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
end

group :test do
  # Make our specs watchable with beautiful progress bar
  gem 'guard-rspec', require: false
  gem 'fuubar'
end

group :test, :development do
  # Get specs involved in this process
  gem 'rspec-rails', '>= 3.5.0'
  gem 'shoulda-matchers', require: false
  gem 'factory_girl_rails'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

group :test, :development do
end

group :test, :development do
end

