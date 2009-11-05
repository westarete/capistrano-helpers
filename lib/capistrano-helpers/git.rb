require File.dirname(__FILE__) + '/../capistrano-helpers' if ! defined?(CapistranoHelpers)

CapistranoHelpers.with_configuration do
  
  # The source code management software to use.
  set :scm, "git"

  # Rather than cloning from github each time, keep a local repo on the server
  # and fetch from that instead. Much faster.
  set :deploy_via, :remote_cache
  
  # By default, it tries to keep git quiet. But this makes older version of 
  # git (like those on our servers) barf, since they don't always support the
  # quiet options.
  set :scm_verbose, true

end
