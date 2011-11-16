_cset(:mysql_user) { "#{application}" } 
set(:mysql_passwd) { Capistrano::CLI.ui.ask("MySQL Password: ") }

namespace :mysql do

  namespace :rails do
     
    desc "Add a mysql yaml configuration file for production"
    task :config, :roles => [:db] do      
      template = File.read("#{template_root}/mysql_rails_template.erb")
      buffer = ERB.new(template).result(binding)  
      put buffer, "#{shared_path}/config/database.yml", :mode => 0644     
    end
    
  end
  
end