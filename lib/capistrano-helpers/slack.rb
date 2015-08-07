require File.dirname(__FILE__) + '/../capistrano-helpers' if ! defined?(CapistranoHelpers)

begin
  require 'slack-notifier'
rescue LoadError
  raise RuntimeError, "The slack-notifier gem is required for Slack deploy notifications. Add it to your Gemfile."
end

require 'git'

CapistranoHelpers.with_configuration do

  namespace :deploy do
    desc "Post to Slack that this deployment is complete"
    task :post_to_slack do
      config_file = fetch(:slack_config, 'config/slack.yml')
      if config_file.nil? || ! File.readable?(config_file)
        puts "Could not find a slack configuration. Skipping slack notification."
      elsif fetch(:slack_notifications, true) == false
        # slack notifications are disabled, nothing to do
      else
        git_config = Git.open('.').config rescue {}
        person = ENV['GIT_AUTHOR_NAME'] || git_config['user.name'] || `whoami`.strip
        app = fetch(:application, nil)
        # If the :branch reference is a full SHA1, display it in its abbreviated form
        version = fetch(:branch).sub(/\b([a-f0-9]{7})[a-f0-9]{33}\b/, '\1')
        environment = fetch(:stage, 'production')

        config = YAML::load_file(config_file)
        slack_options = {}
        slack_options[:channel] = config['channel'] if config['channel']
        slack_options[:username] = config['username'] || 'capistrano'
        slack_options[:icon_emoji] = config['icon_emoji'] if config['icon_emoji']
        slack_options[:icon_url] = config['icon_url'] if config['icon_url']

        notifier = Slack::Notifier.new(config['webhook_url'], slack_options)
        notifier.ping "#{person} just deployed #{app} #{version} to #{environment}"
      end
    end
  end

  after "deploy:restart", "deploy:post_to_slack"
  
end
