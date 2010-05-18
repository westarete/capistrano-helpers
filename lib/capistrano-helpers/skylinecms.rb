require File.dirname(__FILE__) + '/../capistrano-helpers' if ! defined?(CapistranoHelpers)

CapistranoHelpers.with_configuration do
  
  namespace :deploy do
    namespace :skylinecms do
    
      desc "Make certain directories writeable."
      task :make_writeable, :roles => :app do
        # Make this directory writeable so sprockets can compress the javascript.
        run "sudo chown passenger #{release_path}/public/skyline/javascripts"
      end
    
      desc "Create cache directories on the remote server."
      task :create_cache_directories, :roles => :app do
        cache_paths = [
          "#{release_path}/tmp/cache/media_files/cache", 
          "#{release_path}/tmp/cache/rss_sections/cache"
        ]
        cache_paths.each do |cache_path|
          run "if [ ! -d #{cache_path} ] ; then mkdir -p #{cache_path} && sudo chown passenger #{cache_path} ; fi"
        end
      end
      
      desc "Create upload directory on the remote server."
      task :create_upload_directory, :roles => :app do
        shared_upload_path  = "#{shared_path}/tmp/upload"
        release_upload_path = "#{release_path}/tmp/upload"
        # Ensure that the shared directory exists
        run "if [ ! -d #{shared_upload_path} ] ; then mkdir -p #{shared_upload_path} && sudo chown passenger #{shared_upload_path} ; fi"
        # Delete the upload directory that came with the source
        run "rm -rf #{release_upload_path}"
        # Symlink the release directory to the shared directory
        run "ln -s #{shared_upload_path} #{release_upload_path}"
      end
      
      desc "Run skylinecms migrations on the remote server."
      task :migrate, :roles => :app do
        rails_env = fetch(:rails_env, "production")
        run "cd #{release_path} && #{sudo} rake skylinecms:db:migrate RAILS_ENV=#{rails_env}"
      end
      
      desc "Seed roles that are set in the project's fixtures folder."
      task :seed_roles, :roles => :app do
        roles_path = "#{release_path}/db/fixtures/roles.rb"
        rails_env = fetch(:rails_env, "production")
        # Ensure the roles file is executable.
        run "sudo chmod +x #{roles_path}"
        # Run the roles file.
        run "sudo ./#{roles_path} RAILS_ENV=#{rails_env}"
      end
    
    end
  end
  
  # Always run migrations.
  after "deploy:update_code",
          "deploy:skylinecms:make_writeable", 
          "deploy:skylinecms:create_cache_directories", 
          "deploy:skylinecms:create_upload_directory", 
          "deploy:skylinecms:migrate", 
          "deploy:skylinecms:seed_roles"

end
