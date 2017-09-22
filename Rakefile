require 'rake/testtask'
require 'cookstyle'
require 'rubocop/rake_task'
require 'kitchen/rake_tasks'
require 'foodcritic'
require 'kitchen'

# Style tests. Rubocop and Foodcritic
namespace :style do
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:ruby)

  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef) do |t|
    t.options = {
      fail_tags: ['any'],
    }
  end
end

desc 'Run all style checks'
task style: ['style:chef', 'style:ruby']

# Unit tests
Rake::TestTask.new do |t|
  t.libs = %w(libraries)
  t.test_files = FileList['test/unit/*_test.rb']
  t.verbose = true
end

# Optional integration tests with KitchenCI
Kitchen::RakeTasks.new

# Default
task default: ['style', 'test', 'kitchen:all']
