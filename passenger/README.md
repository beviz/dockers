beviz/passenger
---------------

Based on phusion/passenger image, with some improvement and common Rails app features.

Compose Usage:

```
version: '2'

services:
  passenger:
    image: beviz/passenger:latest
    restart: always
    ports:
      - '80'
    volumes:
      - "my_app:/home/app/current"
```

If you need sidekiq service, Customize your Dockerfile

```
FROM bevis/passenger:latest

RUN rm -rf /etc/service/sidekiq/down /etc/service/sidekiq-monitor/down
```
