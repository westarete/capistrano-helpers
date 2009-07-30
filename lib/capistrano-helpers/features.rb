require File.dirname(__FILE__) + '/../capistrano-helpers' if ! defined?(CapistranoHelpers)
require File.dirname(__FILE__) + '/branch'

CapistranoHelpers.with_configuration do
 
  namespace :deploy do
    desc "Make sure all features pass"
    task :check_features do
      if scm != 'git'
        abort "Sorry, you can only check features if you're using git as your scm."
      end
      `git branch` =~ /^\* ([^\s]+)/ or abort "Couldn't understand the output of `git branch`."
      original_branch = $1
      begin
        puts "Checking out #{branch}"
        system("git checkout #{branch}") or raise "Couldn't check out #{branch}."
        puts "Checking features..."
        system("rake features") or raise "One or more features are failing. Come back when they all pass."
        @failed = false
      rescue Exception => e
        puts e
        @failed = true
      ensure
        puts "Going back to branch #{original_branch}"
        system("git checkout #{original_branch}") or abort "Sorry, couldn't put you back to your original branch."
      end
      abort if @failed
    end
  end

  before "deploy:update_code", "deploy:check_features"

end