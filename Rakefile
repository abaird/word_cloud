# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "word_cloud"
  gem.homepage = "http://github.com/abaird/word_cloud"
  gem.license = "MIT"
  gem.summary = %Q{TODO: one-line summary of your gem}
  gem.description = %Q{TODO: longer description of your gem}
  gem.email = "abaird@bairdsnet.net"
  gem.authors = ["Alan Baird"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features)

task :default => :spec

require 'word_cloud'

desc "Generate Wordle word cloud"
task :generate_wordle do
  wb = WordleBrowser.new(WordCloudinator.new("data.yaml"))
  wb.dump_to_wordle
end

desc "Generate Wordle word cloud with colors"
task :generate_wordle_with_colors do
  #wb = WordleBrowser.new(WordCloudinator.new("data_with_colors.yaml"))
  wb = WordleBrowser.new(WordCloudinator.new("data_with_colors_not_so_small.yaml"))
  wb.dump_to_wordle
end