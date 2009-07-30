require File.dirname(__FILE__) + '/../capistrano-helpers' if ! defined?(CapistranoHelpers)

CapistranoHelpers.with_configuration do
 
  desc "Ensure that a branch has been selected."
  task :set_branch do
    if !exists?(:branch)
      set(:branch, Capistrano::CLI.ui.ask("Which tag/branch/commit? "))
    end 
  end

  on :start, :set_branch
  
end
