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

  desc "Download a backup of the production application database"
  task :backup_database, :roles => [:db] do      
    datestring = Time.now.strftime("%d%m%Y")    
    target = "#{shared_path}/config/#{application}_dbbackup_#{datestring}.sql"
    transaction do
      db_root_passwd = Capistrano::CLI.password_prompt("Enter the MySQL root password : ")
      sudo "mysqldump -uroot -p#{db_root_passwd} #{application}_production > #{target}"
      system "scp #{user}@#{servername}:#{target} ./backup/"
      sudo "rm #{target}"
    end 
  end


  namespace :rails do
     
    desc "Add a mysql yaml configuration file for production"
    task :config, :roles => [:db] do      
      buffer = build_template("mysql_rails_template.erb")
      put buffer, "#{shared_path}/config/database.yml", :mode => 0644     
    end 
    
    desc "Link the mysql configuration file"
    task :link_config, :roles => [:app] do
      sudo "ln -nfs #{shared_path}/config/database.yml #{current_path}/config/database.yml"
    end
                                    
  end
  
end