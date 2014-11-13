require File.dirname(__FILE__) + '/../capistrano-helpers' if ! defined?(CapistranoHelpers)

CapistranoHelpers.with_configuration do

  namespace :deploy do
    desc "Disallow robots unless deploying to production."
    task :disallow_robots do
      unless stage == :production
        run %{cd #{release_path} && echo "User-agent: *\\nDisallow: /\\n" > public/robots.txt}
      end
    end
  end
  after "deploy:update_code", "deploy:disallow_robots"

end
