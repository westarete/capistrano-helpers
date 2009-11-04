require File.dirname(__FILE__) + '/../capistrano-helpers' if ! defined?(CapistranoHelpers)

begin
  # Campfire API gem for deploy notifications.
  require 'tinder'
rescue LoadError
  abort "The campfire helper requires the tinder gem. Install it with: sudo gem install tinder"
end

CapistranoHelpers.with_configuration do
  
  namespace :deploy do
    desc 'Make a post to campfire to tell everyone about this deployment.'
    task :post_to_campfire do
      if !exists?(:application)
        puts "You should set :application to the name of this app."
      end
      username = `whoami`.chomp
      config_file = fetch(:campfire_config, 'config/campfire.yml')
      config = YAML::load_file(config_file)
      campfire = Tinder::Campfire.new(config['account'])
      campfire.login(config['email'], config['password'])
      room = campfire.find_room_by_name(config['room'])
      room.speak("#{username} just deployed #{application} #{branch} to #{stage}")
      room.leave
    end
  end

  after "deploy:restart", "deploy:post_to_campfire"

end