unless Capistrano::Configuration.respond_to?(:instance)
  abort "capistrano/ext/campfire requires Capistrano 2"
end

Capistrano::Configuration.instance(:must_exist).load do
 
  desc "Ensure that a branch has been selected."
  task :set_branch do
    if !exists?(:branch)
      set(:branch, Capistrano::CLI.ui.ask("Which tag/branch/commit? "))
    end 
  end

  on :start, :set_branch
  
end
