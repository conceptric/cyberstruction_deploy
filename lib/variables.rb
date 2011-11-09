Capistrano::Configuration.instance(:must_exist).load do

# Check whether the variable has been set
def _cset(name, *args, &block)
  unless exists?(name)
    set(name, *args, &block)
  end
end

# =========================================================================
# These variables MUST be set in the client capfiles. If they are not set,
# the deploy will fail with an error.
# =========================================================================
 
_cset(:application) { abort "Please specify the name of your application" }
_cset(:primary_app_domain_name) { abort "Please specify a primary domain name for your application" }

# =========================================================================
# These variables may be set in the client capfile if their default values
# are not sufficient.
# =========================================================================

_cset(:template_root) { File.expand_path('../../templates', __FILE__) }
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
  
end