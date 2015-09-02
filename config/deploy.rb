require 'mina/git'
require 'mina/bundler'
require 'mina/rbenv'

set :domain, '198.20.105.55'
set :deploy_to, '/home/bump'
set :repository, 'https://github.com/jaturken/bump.git'
set :branch, 'master'
set :user, 'bump'
set :shared_paths, ['config/database.yml', 'config/secrets.yml', 'log', 'tmp/sockets', 'tmp/pids']

task :environment do
  invoke :'rbenv:load'
end

task :setup => :environment do
  # queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp/pids"]
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp/sockets"]
  # queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  # queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  # queue! %[touch "#{deploy_to}/#{shared_path}/config/secrets.yml"]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  to :before_hook do
  end
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'deploy:cleanup'

    to :launch do
      queue "mkdir -p #{deploy_to}/#{current_path}/tmp/"
      queue "touch #{deploy_to}/#{current_path}/tmp/restart.txt"
    end
  end
end
