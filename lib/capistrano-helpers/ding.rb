require File.dirname(__FILE__) + '/../capistrano-helpers' if ! defined?(CapistranoHelpers)

CapistranoHelpers.with_configuration do

  namespace :deploy do
    desc "Play a 'ding' sound once deploy is complete (Mac only)"
    task :ding_notify do
      system 'afplay /System/Library/Sounds/Glass.aiff'
    end
  end

  after "deploy:restart", "deploy:ding_notify"

end
