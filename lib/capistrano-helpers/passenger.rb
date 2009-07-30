require File.dirname(__FILE__) + '/../capistrano-helpers' if ! defined?(CapistranoHelpers)

CapistranoHelpers.with_configuration do
 
  namespace :deploy do
    desc 'Restart passenger'
    task :restart, :roles => :app do
      run "touch #{release_path}/tmp/restart.txt"
    end
  end

end