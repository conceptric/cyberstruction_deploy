# Default apache settings
_cset(:apachectl_command) { "/usr/sbin/apache2ctl" }                   
_cset(:apache_vhost_available_path) {
   "/etc/apache2/sites-available/#{application}" 
   }
_cset(:apache_vhost_enabled_path) { 
  "/etc/apache2/sites-enabled/#{application}" 
  }
_cset(:apache_vhost_aliases) { 
  ["www.#{primary_app_domain_name}"] 
  }
      
# Recipes for controlling web server configuration and operation on Ubuntu
namespace :apache do

  # Build the Apache configuration file for the application from a template
  task :upload_vhost_conf_file, :roles => [:web] do 
    buffer = build_template("apache_vhost_template.erb")
    put buffer, "#{shared_path}/httpd.conf", :mode => 0644
  end

  desc "Add an Apache vhost configuration file"
  task :add_apache_vhost, :roles => [:web] do
    transaction do
      apache.upload_vhost_conf_file
      sudo "cp #{shared_path}/httpd.conf #{apache_vhost_available_path}"
      run "rm -f #{shared_path}/httpd.conf"    
    end
  end
  
  desc "Remove the Apache vhost configuration file"
  task :remove_apache_vhost, :roles => [:web] do
    transaction do
      apache.disable_application
      sudo "rm -f #{apache_vhost_available_path}"
    end
  end
  
  desc "Enable the application on the Web Server"
  task :enable_application, :roles => [:web] do
    sudo "ln -nfs #{apache_vhost_available_path} #{apache_vhost_enabled_path}"
    config_test
    restart   
  end

  desc "Disable the application on the Web Server"
  task :disable_application, :roles => [:web] do
    sudo "rm -f #{apache_vhost_enabled_path}"
    restart    
  end

  desc "Test Apache Configuration"
  task :config_test, :roles => [:web] do
    sudo "#{apachectl_command} configtest"
  end

  desc "Start Apache"
  task :start, :roles => [:web] do
    sudo "#{apachectl_command} start"
  end

  desc "Restart Apache"
  task :restart, :roles => [:web] do
    sudo "#{apachectl_command} graceful"
  end

  desc "Stop Apache"
  task :stop, :roles => [:web] do
    sudo "#{apachectl_command} graceful-stop"
  end

end
