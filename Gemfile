source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

branch = ENV.fetch('OPEN_BRANCH', 'master')
gem 'open', github: '99cm/open', branch: 'master'
gem "rails-controller-testing"

gem 'deface', require: false

gemspec