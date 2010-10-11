# Capistrano-Helpers Changelog

## 0.5.4

Changed:

* Tolerate a missing campfire.yml.

## 0.5.3

Changed:

* Don't install :development or :test groups when deploying with bundler.

## 0.5.0

New:

* Added a Bundler helper. It automatically runs "bundle install --deployment" at the appropriate time.

## 0.4.4

Fixed:

* Using the newest version of the Tinder gem. At some point the Campfire API changed, so we're changing with it.

## 0.4.3

Removed:

* Functionality to seed roles. This sort of task should be done as a typical migration, not in a Capistrano recipe.

## 0.4.2

New: 

* Adding cache folders for a Skyline installation.

Fixed:

* Misspellings with regards to the SkylineCMS gem fixed.

## 0.4.1

New:

* Added "deploy:skyline:seed_roles" for SkylineCMS helper. This reseeds role information for Skyline projects.

## 0.4.0

New:

* Wrote new helpers for SkylineCMS. See http://skylinecms.nl
* Changes permissions on folders. Some things like Sprockets require folders to be writable.
* Creates the needed cache directories, with appropriate permissions.
* Creates upload folder if it doesn't exist, then creates the symlink to it.
* Runs skyline's migrations on the remote server.
  
## Pre-0.4.0

* CHANGELOG was just created. Please see git commit history for more information.
