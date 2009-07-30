require File.dirname(__FILE__) + '/../capistrano-helpers' if ! defined?(CapistranoHelpers)

CapistranoHelpers.with_configuration do
 
  namespace :deploy do
    desc 'Replace named files with a symlink to their counterparts in shared/private/'
    task :symlink_privates do
      if !exists?(:privates)
        abort 'You must specify which privates to symlink using the "set :privates" command.'
      end
      privates.each do |path|
        run "ln -nfs #{shared_path}/private/#{path} #{release_path}/#{path}"
      end
    end
  end

  after "deploy:update_code", "deploy:symlink_privates"

end