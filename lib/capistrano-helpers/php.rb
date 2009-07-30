require File.dirname(__FILE__) + '/../capistrano-helpers' if ! defined?(CapistranoHelpers)

CapistranoHelpers.with_configuration do
 
  namespace :deploy do
    task :restart do
      # No need to restart the web server. 
    end

    task :finalize_update do
      # No need to make any extra symlinks.
    end
  end

end
