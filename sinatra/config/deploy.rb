set :user, 'i0n'
set :domain, "thoughtplant"
set :application, "PROJECT_NAME"

set :repository,  "#{user}@#{domain}:/home/#{user}/git/#{application}.git"

role :app, domain                           # This may be the same as the `Web` server
role :web, domain                           # Your HTTP server, Apache/etc
role :db,  domain , :primary => true        # This is where Rails migrations will run

set :scm_verbose, false

set :scm, :git
set :scm_username, user
set :runner, user
set :use_sudo, true
set :branch, "master"
set :deploy_via, :checkout
set :git_shallow_clone, 1
set :deploy_to, "/home/#{user}/sites/#{application}"
default_run_options[:pty] = true

namespace :deploy do
  
  desc "Restart Passenger"
  task  :restart do
    run "mkdir -p #{release_path}/tmp && touch #{release_path}/tmp/restart.txt"
  end
      
  desc "Set up the remote Nginx server for app deployment"
  task :nginx do
    run "#{sudo} nginx_auto_config '/opt/nginx/conf/nginx.conf' \"
    server {
      listen 80;
      server_name #{application}.com;
      gzip on;
      gzip_proxied any;
      gzip_vary on;
      gzip_disable 'MSIE [1-6]\\.';
      gzip_http_version 1.1;
      gzip_min_length 10;
      gzip_comp_level 9;
      gzip_types text/plain application/xhtml+xml text/css application/x-javascript text/xml application/xml;
      location / {
        root /home/i0n/sites/#{application}/current/public/;
        passenger_enabled on;
        if (\\$request_filename ~ '.+\\.(jpg|jpeg|gif|css|png|js|ico|html)$') { access_log off; expires 30d; }
      }
    }
    \"
    "
  end

  desc "Create bare remote git repo then add remote origin to local git repo and push to remote"
  task :git do
    run "cd /home/#{user}/git; mkdir #{application}.git; cd #{application}.git; git init --bare"
    `git remote add origin ssh://#{user}@#{domain}/~/git/#{application}.git`
    `git push origin master`
  end
    
end

# Reminder of default actions for cap deploy:
# deploy:update_code
# deploy:symlink
# deploy:restart
