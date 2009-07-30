unless Capistrano::Configuration.respond_to?(:instance)
  abort "capistrano/ext/campfire requires Capistrano 2"
end

Capistrano::Configuration.instance(:must_exist).load do
 
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