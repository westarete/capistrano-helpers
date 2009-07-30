unless Capistrano::Configuration.respond_to?(:instance)
  abort "capistrano/ext/campfire requires Capistrano 2"
end

Capistrano::Configuration.instance(:must_exist).load do
 
  namespace :deploy do
    task :restart do
      # No need to restart the web server. 
    end

    task :finalize_update do
      # No need to make any extra symlinks.
    end
  end

end
