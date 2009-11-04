require File.dirname(__FILE__) + '/../capistrano-helpers' if ! defined?(CapistranoHelpers)

CapistranoHelpers.with_configuration do
  
  namespace :gems do
    desc "Install gems on the remote server."
    task :install, :roles => :app do
      run "cd #{current_release} && #{sudo} RAILS_ENV=#{rails_env} rake gems:install"
    end
  end
  
  after "deploy:update_code", "gems:install"

end
