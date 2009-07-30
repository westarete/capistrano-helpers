unless Capistrano::Configuration.respond_to?(:instance)
  abort "capistrano/ext/campfire requires Capistrano 2"
end

Capistrano::Configuration.instance(:must_exist).load do
 
  namespace :deploy do
    # Tell passenger to restart.
    task :restart, :roles => :app do
      run "touch #{release_path}/tmp/restart.txt"
    end
  end

end