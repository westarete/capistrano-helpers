# Capistrano-Helpers Changelog

## 0.4.0

New:

* Wrote new helpers for SkylineCMS. See http://skylinecms.nl

  * Changes permissions on folders. Some things like Sprockets require folders to be writable.
  * Creates the needed cache directories, with appropriate permissions.
  * Creates upload folder if it doesn't exist, then creates the symlink to it.
  * Runs skyline's migrations on the remote server.
  
## Pre-0.4.0

* CHANGELOG was just created. Please see git commit history for more information.
