require File.dirname(__FILE__) + '/../capistrano-helpers' if ! defined?(CapistranoHelpers)

CapistranoHelpers.with_configuration do
 
  namespace :deploy do
    desc "Send a notification to Growl once deploy is complete, if available"
    task :growl_notify do
      if ! exists?(:application)
        puts "You should set :application to the name of this app."
      end

      # If the :branch reference is a full SHA1, display it in its abbreviated form
      growl_branch = fetch(:branch).sub(/\b([a-f0-9]{7})[a-f0-9]{33}\b/, '\1')
      target = fetch(:stage, 'production')

      system %{growlnotify -n "capistrano" -m "finished deploying #{application} #{growl_branch} to #{target}"}
    end
  end

  after "deploy:restart", "deploy:growl_notify"

end
