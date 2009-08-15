require 'capistrano'

unless Capistrano::Configuration.respond_to?(:instance)
  abort "capistrano-helpers requires Capistrano 2"
end

class CapistranoHelpers
  
  # Execute the given block of code within the context of the capistrano
  # configuration.
  def self.with_configuration(&block)
    Capistrano::Configuration.instance(:must_exist).load(&block)
  end
  
end
