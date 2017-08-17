#!/bin/bash

cd /home/app/current
exec 2>&1
exec chpst -u app bundle exec sidekiq --index 0 --pidfile /home/app/shared/tmp/pids/sidekiq-0.pid --environment production --logfile /home/app/shared/log/sidekiq.log --config config/sidekiq.yml
