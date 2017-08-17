FROM phusion/passenger-ruby23

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

# for carrierwave
RUN apt-get install -y libmagickwand-dev imagemagick

# for js runtime
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g yarn

RUN apt-get install -y ghostscript
RUN apt-get install -y libav-tools

# tools
RUN apt-get install -y rsync
RUN apt-get install -y tmux

ENV HOME /root

CMD ["/sbin/my_init"]

EXPOSE 80

# enable ssh
RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
EXPOSE 22

# add ssh keys
# ADD authorized_keys /root/.ssh/
# RUN chmod 600 /root/.ssh/authorized_keys
RUN chown -R app:app /home/app
# RUN chmod 600 /home/app/.ssh/authorized_keys

# app user
RUN usermod -a -G docker_env app
RUN passwd -u app

# Timezone
RUN echo Asia/Beijing > /etc/timezone
# RUN cp -f /usr/share/zoneinfo/Asia/Beijing /etc/localtime

# passenger
RUN rm -f /etc/service/nginx/down
RUN rm /etc/nginx/sites-enabled/default
ADD conf.d/nginx.conf /etc/nginx/sites-enabled/default
ADD conf.d/rails-env.conf /etc/nginx/main.d/rails-env.conf
ADD conf.d/passenger.conf /etc/nginx/conf.d/passenger.conf

# Sidekiq
COPY conf.d/sidekiq-monitor-run.sh /etc/service/sidekiq-monitor/run
COPY conf.d/sidekiq-run.sh /etc/service/sidekiq/run
COPY conf.d/sidekiq-finish.sh /etc/service/sidekiq/finish
RUN apt-get install -y inotify-tools \
 && chmod +x /etc/service/sidekiq-monitor/run \
 && chmod +x /etc/service/sidekiq/run \
 && chmod +x /etc/service/sidekiq/finish \
 && touch /etc/service/sidekiq-monitor/down \
 && touch /etc/service/sidekiq/down

# Enable Sidekiq
# COPY conf.d/01_enable_sidekiq.sh /etc/my_init.d/01_enable_sidekiq.sh
# RUN chmod +x /etc/my_init.d/01_enable_sidekiq.sh

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
