require File.dirname(__FILE__) + '/../capistrano-helpers' if ! defined?(CapistranoHelpers)

begin
  require 'tinder'
rescue LoadError
  raise RuntimeError, "tinder gem required for Campfire deploy notifications.  Run `sudo gem install tinder`, or add `gem 'tinder'` to your Gemfile."
end

require 'git'

CapistranoHelpers.with_configuration do

  namespace :deploy do
    desc "Post to campfire that this deployment is complete"
    task :post_to_campfire_after do
      post_to_campfire(:after)
    end

    desc "Post to campfire that this deployment has begun"
    task :post_to_campfire_before do
      post_to_campfire(:before)
    end

    def post_to_campfire(hook=:before)
      case hook
      when :before
        action = 'started deploying'
      when :after
        action = 'finished deploying'
      else
        return
      end

      # If the :branch reference is a full SHA1, display it in its abbreviated form
      campfire_branch = fetch(:branch).sub(/\b([a-f0-9]{7})[a-f0-9]{33}\b/, '\1')

      config_file = [fetch(:campfire_config, 'config/campfire.yml'), "#{ENV['HOME']}/.campfire.yml"].detect { |f| File.readable?(f) }
      if config_file.nil?
        puts "Could not find a campfire configuration. Skipping campfire notification."
      elsif fetch(:campfire_notifications, true) == false
        # Campfire notifications are disabled, nothing to do
      else
        if ! exists?(:application)
          puts "You should set :application to the name of this app."
        end
        git_config = Git.open('.').config rescue {}
        someone = ENV['GIT_AUTHOR_NAME'] || git_config['user.name'] || `whoami`.strip
        target = fetch(:stage, 'production')
        config = YAML::load_file(config_file)
        campfire = Tinder::Campfire.new(config['subdomain'], :token => config['token'])
        room = campfire.find_room_by_name(config['room'])
        room.speak("#{someone} #{action} #{application} #{campfire_branch} to #{target}")
      end
    end
  end

  after "deploy:restart", "deploy:post_to_campfire_after"

end
