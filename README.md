# capistrano-helpers

A set of optional extensions to capistrano to make common tasks easier and
reduce redundancy across your deployments.

## Usage

In your capistrano deploy recipe, simply require the helpers that contain the
functionality that you would like to add to your recipe. In most cases this
also takes care of adding the hook so that the action takes place at the right
time during deployment.

Here's an example config/deploy.rb that uses a few helpers:

    require 'capistrano-helpers/passenger' # Support for Apache passenger
    require 'capistrano-helpers/specs'     # Check specs before deploying
    require 'capistrano-helpers/version'   # Record the version number after deploying
    require 'capistrano-helpers/campfire'  # Post deploy info to campfire
  
    # The name of the application.
    set :application, "myapp"
  
    # The source code management software to use.
    set :scm, "git"
  
    # Location of the source code.
    set :repository,  "git@github.com:mycompany/myapp.git"

That's it! The recipe will now also perform the actions described by the
helpers (in this case, the campfire helper also requires the tinder gem and
a config/campfire.yml file).

## Helpers

### branch

Prompts the user for the particular tag/branch/commit to deploy.

### bundler

Automatically runs `bundle install --deployment` to install gems from your Gemfile at the appropriate time.

[Deprecated] This recipe predates bundler's direct support for capistrano. It's best to 
`require 'bundler/capistrano'` in your recipe now instead of using this helper.

### campfire

Once the deploy is complete, this helper will post a message to the given
Campfire room stating the username, the application, the branch/tag and the
environment. E.g.:

    Scott Woods finished deploying myapp v0.5.4 to staging

By default, it will only post when the deploy is complete. If you'd also
like it to post when the deploy begins, you can add the following line
to your deploy script:

    before "deploy", "deploy:post_to_campfire_before"

You will need to install the tinder gem to enable campfire notifications.  Run
<tt>sudo gem install tinder</tt>, or add <tt>gem 'tinder'</tt> to your Gemfile.
This helper expects to find a configuration file config/campfire.yml or
~/.campfire.yml with the following format:

    # Configuration for posting to campfire.
    subdomain: mycompany
    token: abcd1234567890
    room: Chatter

You can override the location of the configuration file by setting the
:campfire_config variable:

    set :campfire_config, 'somewhere/else.yml'

You can disable the notification for a specific deployment stage by setting
the :campfire_notifications variable to false.
E.g. in config/deploy/staging:

    set :campfire_notifications, false

### ding

Once the deploy is complete, this helper will play a 'ding' sound (Mac only).

### features

Before the app is deployed, this helper checks out the branch/tag that is
being deployed and runs all the cucumber features, ensuring that they all
pass.

### gems

Run the gems:install rake task using sudo after deployment.

### git

Set git as the repository type, and set up remote caching to speed up
deployments.

### growl

Once the deploy is complete, this helper will post a message to Growl stating
the application, the branch/tag and the environment. E.g.:

    capistrano
  
    finished deploying myapp v0.5.4 to staging

### jekyll

Deploy a static website with [jekyll](http://jekyllrb.com/). Rebuild the site
during deployment, and override any server restarts (since it's just a static
site).

### migrations

Always run migrations during deployment.

### passenger

Overrides the default :restart task so that it's compatible with restarting
apache/passenger (aka mod_rails). Touches tmp/restart.txt.

### php

Use this helper when using capistrano to deploy a purely PHP application.

This neuters the default :restart and :finalize_updates tasks, since they
aren't typically needed for a PHP installation.

### preflight

Goes through a set of yes/no questions with the user before the application is
actually deployed. This provides a way to walk the user through a set of
reminders. The deploy only proceeds if the user answers each question
affirmatively.

This helper expects to find the questions in a configuration file called
config/preflight.yml . The file should be in the following format:

    # Questions that must be answered "yes" before a deploy is allowed to proceed.
    - Does cruise control show all tests passing?
    - Do the staging and production servers have the required gems installed?
    - Are you prepared to run migrations on the remote server?
    - Have you tagged this release?
    - Have you pushed the tags to github?
  
You can override the location of the configuration file by setting the
:preflight_config variable:

    set :preflight_config, 'somewhere/else.yml'

### robots

Unless deploying to production, write a `public/robots.txt` file that will
disallow all search engine bots and crawlers. This prevents your staging and
beta sites from being indexed by Google.

### shared

During deployment, this helper replaces each of the given paths with a
symbolic link that points to the same path under the "shared" directory on the
server. This is useful for setting up files and directories that contain
data that should persist across deployments (uploads, for example).

After requiring this helper, set the paths to be symlinked using the
:shared variable:

    set :shared, %w{
      public/uploads
      public/downloads/huge_files
    }

This will create two symbolic links on the production server:

    #{release_path}/public/uploads -> #{shared_path}/public/uploads
    #{release_path}/public/downloads/huge_files -> #{shared_path}/public/downloads/huge_files

### skylinecms

This is for the SkylineCMS gem. Skyline requires certain permissions and folders to operate,
and this helper insures they exist. Remember to run this *after* the rest of your symlinks exist
(eg. config/database.yml) and *before* anything loads the environment (eg. rake gems:install).

### privates

This works much like the shared helper above, except the symbolic link will
point to the same path under "shared/private" on the server. This allows you
to set special permissions on that directory for keeping particularly
sensitive files safe, such as those that contain passwords or encryption keys.

After requiring this helper, set the paths to be symlinked using the
:privates variable:

    set :privates, %w{
      config/database.yml
      config/session_secret.txt
    }
  
This will create two symbolic links on the production server:

    #{release_path}/config/database.yml -> #{shared_path}/private/config/database.yml
    #{release_path}/config/session_secret.txt -> #{shared_path}/private/config/session_secret.txt
  
### slack

Once the deploy is complete, this helper will post a message to the given
Slack room stating the username, the application, the branch/tag and the
environment. E.g.:

    Scott Woods just deployed myapp v0.5.4 to staging

You will need to add the <tt>slack-notifier</tt> gem to your Gemfile.

This helper also expects to find a configuration file <tt>config/slack.yml</tt> 
with the following format:

    # This file is used for developer chat room notifications.
    webhook_url: "https://hooks.slack.com/services/YOUR_SLACK_WEBHOOK_HERE"
    channel: "#flip-learning"
    username: "capistrano"
    icon_emoji: ":bird:"

You can override the location of the configuration file by setting the
:slack_config variable:

    set :slack_config, 'somewhere/else.yml'

You can disable the notification for a specific deployment stage by setting
the :slack_notifications variable to false, e.g. in config/deploy/staging:

    set :slack_notifications, false

### specs

Before the app is deployed, this helper checks out the branch/tag that is
being deployed and runs all the rspec specs, ensuring that they all pass.

### unicorn

Overrides the default :restart task so that it's compatible with restarting
unicorn.

### version

Creates a VERSION file in the deployed copy that contains the name of the
branch/tag that was deployed. Useful for displaying version information in the
app itself.

## Copyright

Copyright (c) 2014 West Arete Computing, Inc.
