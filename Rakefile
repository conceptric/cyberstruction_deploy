require 'rubygems'
require 'rake'

desc "Update the gem bundle and use the test app to check the task list"
task :task_list do
  system "bundle"
  system "cd ./test/app && cap -T"
end