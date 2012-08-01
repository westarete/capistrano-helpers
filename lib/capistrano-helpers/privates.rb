require File.dirname(__FILE__) + '/../capistrano-helpers' if ! defined?(CapistranoHelpers)

CapistranoHelpers.with_configuration do

  namespace :deploy do
    desc 'Replace named files with a symlink to their counterparts in shared/private/'
    task :symlink_privates do
      if !exists?(:privates)
        abort 'You must specify which privates to symlink using the "set :privates" command.'
      end
      privates.each do |path|
        if release_path.nil? || release_path.empty? || path.nil? || path.empty?
          raise "Release path or path are nil!"
        end
        run "rm -rf #{release_path}/#{path} && ln -nfs #{shared_path}/private/#{path} #{release_path}/#{path}"
      end
    end

    desc '[internal] Create a private directory in shared'
    task :create_private_dir do
      private_dir = 'private'
      private_path = File.join(shared_path, private_dir)
      run "#{try_sudo} mkdir -p #{private_path}"
      run "#{try_sudo} chmod o-rwx #{private_path}"
    end
  end

  before "deploy:finalize_update", "deploy:symlink_privates"
  after "deploy:setup", "deploy:create_private_dir"

end
