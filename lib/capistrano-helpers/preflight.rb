require File.dirname(__FILE__) + '/../capistrano-helpers' if ! defined?(CapistranoHelpers)

CapistranoHelpers.with_configuration do
 
  namespace :deploy do
    desc 'Go through the preflight checklist'
    task :preflight do
      puts 'Going through preflight checklist:'
      config_file = fetch(:preflight_config, 'config/preflight.yml')
      questions = YAML::load_file(config_file)
      questions.map! { |q| " * #{q} " }
      questions.each do |question|
        response = Capistrano::CLI.ui.ask(question)
        if response !~ /y(es)?/i
          abort 'Come back when you can answer "yes" to all the deploy questions.'
        end
      end
    end
  end

  before "deploy:update_code", "deploy:preflight"

end