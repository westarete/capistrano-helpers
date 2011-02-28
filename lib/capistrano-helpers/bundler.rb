require File.dirname(__FILE__) + '/../capistrano-helpers' if ! defined?(CapistranoHelpers)

CapistranoHelpers.with_configuration do

  namespace :deploy do
    desc "Install gems on the remote server using Bundler."
    task :bundler do
      run "sudo chown -Rh `whoami` #{shared_path}/vendor/bundler"
      run "cd #{current_path} && bundle install --deployment --local --path #{shared_path}/vendor/bundler --without development test"
    end
  end

  after "deploy:symlink_shared", "deploy:bundler"

end
