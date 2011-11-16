# Check whether the variable has been set
def _cset(name, *args, &block)
  unless exists?(name)
    set(name, *args, &block)
  end
end

require "#{File.dirname(__FILE__)}/variables"
require "#{File.dirname(__FILE__)}/apache"
