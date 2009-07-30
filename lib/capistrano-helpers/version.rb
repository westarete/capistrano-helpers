require File.dirname(__FILE__) + '/branch'

unless Capistrano::Configuration.respond_to?(:instance)
  abort "capistrano/ext/campfire requires Capistrano 2"
end

Capistrano::Configuration.instance(:must_exist).load do
 
  namespace :deploy do
    desc "Write the name of the tag that we're deploying to a VERSION file"
    task :write_version_file do
      run "echo -n \"#{branch}\" > #{release_path}/VERSION"
    end
  end

  after "deploy:update_code", "deploy:write_version_file"

end