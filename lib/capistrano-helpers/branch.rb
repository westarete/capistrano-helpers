require File.dirname(__FILE__) + '/../capistrano-helpers' if ! defined?(CapistranoHelpers)
require 'versionomy'

CapistranoHelpers.with_configuration do
 
  desc "Ensure that a branch has been selected."
  task :set_branch do
    if !exists?(:branch)
      latest_version = `git tag`.split.select { |s| s =~ /\d\.\d/ }.map { |s| Versionomy.parse(s) }.sort.last.to_s
      prompt = latest_version ? " [#{latest_version}]" : ""
      begin
        response = Capistrano::CLI.ui.ask("Which tag/branch/commit#{prompt}? ").strip
        response = latest_version if response.empty?
      end while response.empty?
      set(:branch, response)
    end 
  end

  on :start, :set_branch
  
end
