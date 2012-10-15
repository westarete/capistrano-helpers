require File.dirname(__FILE__) + '/../capistrano-helpers' if ! defined?(CapistranoHelpers)

CapistranoHelpers.with_configuration do

  namespace :unicorn do
    desc "Restart unicorn"
    task :restart, :roles => :web, :except => { :no_release => true } do
      run "oldpid=$(cat /var/www/#{application}/#{stage}/shared/pids/unicorn.pid) && kill -s USR2 $oldpid && echo 'Searching for newly spawned master process...' && until (pid=$(cat /var/www/#{application}/#{stage}/shared/pids/unicorn.pid 2>/dev/null) && test '$pid' != '$oldpid' && ps x |grep $pid|grep master) ; do sleep 1 ; done && kill -s WINCH $oldpid && kill -s QUIT $oldpid"
    end
  end
  after "deploy:restart", "unicorn:restart"

end
