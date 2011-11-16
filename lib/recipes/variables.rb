# Default global settings
_cset(:application) { abort "Please specify the name of your application" }
_cset(:primary_app_domain_name) { abort "Please specify a primary domain name for your application" }
_cset(:template_root) { File.expand_path('../../templates', __FILE__) }
