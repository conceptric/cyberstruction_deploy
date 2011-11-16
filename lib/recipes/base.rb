namespace :deploy do
  
  after "deploy:setup", "deploy:setup_config"
  after "deploy:setup", "deploy:set_permissions"

  desc "Make a shared config directory"
  task :setup_config do
    sudo "mkdir -p #{shared_path}/config"
  end
  
  desc "Set permissions"
  task :set_permissions do
    sudo "chown -R #{user}:#{user} #{deploy_to}"
  end
  
  # Added for Passenger compatibility 
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

end