# encoding: UTF-8

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'open_auth_devise'
  s.version     = '2.5.0'
  s.summary     = 'Provides authentication and authorization services for Open store with Devise and CanCan.'
  s.description = s.summary

  s.required_ruby_version = '>= 2.5.1'

  s.author      = 'China Guide Tech Team'
  s.email       = 'contact@china-guide.com'

  s.license     = 'BSD-3-Clause'

  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'devise', '~> 4.5.0'
  s.add_dependency 'devise-encryptable', '0.2.0'

  open_version = '>= 2.5.0'
  s.add_dependency 'open_core', open_version

  s.add_development_dependency 'capybara', '~> 2.7'
  s.add_development_dependency 'capybara-screenshot'
  s.add_development_dependency 'database_cleaner', '~> 1.5'
  s.add_development_dependency 'email_spec', '~> 2.1'
  s.add_development_dependency 'factory_bot', '~> 4.10.0'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rspec-rails', '~> 3.5'
  s.add_development_dependency 'shoulda-matchers', '~> 3.1'
  s.add_development_dependency 'simplecov', '~> 0.12'
  s.add_development_dependency 'open_backend', open_version
  s.add_development_dependency 'open_frontend', open_version
  s.add_development_dependency 'sqlite3'
end