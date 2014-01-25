# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "capistrano-helpers"
  s.version = "0.8.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Scott Woods"]
  s.date = "2013-11-06"
  s.description = "A set of optional extensions to capistrano to make common tasks easier."
  s.email = "team@westarete.com"
  s.license = 'MIT'
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "capistrano-helpers.gemspec",
    "lib/capistrano-helpers.rb",
    "lib/capistrano-helpers/branch.rb",
    "lib/capistrano-helpers/bundler.rb",
    "lib/capistrano-helpers/campfire.rb",
    "lib/capistrano-helpers/features.rb",
    "lib/capistrano-helpers/gems.rb",
    "lib/capistrano-helpers/git.rb",
    "lib/capistrano-helpers/migrations.rb",
    "lib/capistrano-helpers/passenger.rb",
    "lib/capistrano-helpers/php.rb",
    "lib/capistrano-helpers/preflight.rb",
    "lib/capistrano-helpers/privates.rb",
    "lib/capistrano-helpers/shared.rb",
    "lib/capistrano-helpers/skylinecms.rb",
    "lib/capistrano-helpers/specs.rb",
    "lib/capistrano-helpers/unicorn.rb",
    "lib/capistrano-helpers/version.rb",
    "test/test_helper.rb"
  ]
  s.homepage = "http://github.com/westarete/capistrano-helpers"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "A set of optional extensions to capistrano to make common tasks easier."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capistrano>, ["~> 2.0"])
      s.add_runtime_dependency(%q<git>, [">= 0"])
      s.add_runtime_dependency(%q<versionomy>, [">= 0"])
    else
      s.add_dependency(%q<capistrano>, ["~> 2.0"])
      s.add_dependency(%q<git>, [">= 0"])
      s.add_dependency(%q<versionomy>, [">= 0"])
    end
  else
    s.add_dependency(%q<capistrano>, ["~> 2.0"])
    s.add_dependency(%q<git>, [">= 0"])
    s.add_dependency(%q<versionomy>, [">= 0"])
  end
end

