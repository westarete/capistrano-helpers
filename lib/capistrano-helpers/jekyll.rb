require File.dirname(__FILE__) + '/../capistrano-helpers' if ! defined?(CapistranoHelpers)

CapistranoHelpers.with_configuration do

  namespace :deploy do
    desc "Regenerate the site using jekyll."
    task :jekyll_build do
      run "cd #{release_path} && bundle exec jekyll build"
    end

    task :restart do
      # No need to restart the web server.
    end

    task :finalize_update do
      # No need to make any extra symlinks.
    end
  end

  after "deploy:update_code", "deploy:jekyll_build"

end
