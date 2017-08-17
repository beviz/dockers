#!/bin/bash

exec 2>&1
exec rm -rf /etc/service/sidekiq/down /etc/service/sidekiq-monitor/down
