require File.dirname(__FILE__) + '/../capistrano-helpers' if ! defined?(CapistranoHelpers)

CapistranoHelpers.with_configuration do

  namespace :deploy do
    desc "Install gems on the remote server using Bundler."
    task :bundler do
      run "cd #{release_path} && bundle install --deployment --path #{shared_path}/vendor/bundler"
    end
  end

  after "deploy:symlink_shared", "deploy:bundler"

end