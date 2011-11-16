_cset(:mysql_user) { "#{application}" } 
set(:mysql_passwd) { Capistrano::CLI.password_prompt("Enter MySQL User Password: ") }

namespace :mysql do

  desc "Create a new database for the application"
  task :create_database, :roles => [:db] do          
    target = "#{shared_path}/config/database_setup.sql"
    buffer = build_template("new_mysql_database_template.erb")  
    transaction do
      put buffer, target, :mode => 0644     
      db_root_passwd = Capistrano::CLI.password_prompt("Enter the MySQL root password : ")
      sudo "mysql -uroot -p#{db_root_passwd} < #{target}"
      sudo "rm #{target}"
    end 
  end

  namespace :rails do
     
    desc "Add a mysql yaml configuration file for production"
    task :config, :roles => [:db] do      
      buffer = build_template("mysql_rails_template.erb")
      put buffer, "#{shared_path}/config/database.yml", :mode => 0644     
    end
    
  end
  
end