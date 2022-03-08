#
# Cookbook:: lamp
# Recipe:: multisites
#
# Copyright:: 2022, The Authors, All Rights Reserved.

directory "Create a directory" do
  path "/etc/httpd/sites-available"
end

directory "Create a directory" do
  path "/etc/httpd/sites-enabled"
end

directory "Create a directory" do
  path "/var/www/sites"
end

node["lamp_stack"]["sites"].each do |sitename, data|
directory "Create a directory" do
  path "/var/www/sites/#{sitename}"  
end

directory "Create a directory" do
  path "/var/log/httpd/#{sitename}"
end

template "/etc/httpd/sites-available/#{sitename}.conf" do
 source 'conf.erb'
 action :create
 variables(
      :servername => data["servername"],
      :env => data["name"]
    )
end

template "/var/www/sites/#{sitename}/info.html" do
 source 'info.html.erb'
 action :create
 variables(
      :env => data["name"]
    )
end

link "/etc/httpd/sites-enabled/#{sitename}.conf" do
  to "/etc/httpd/sites-available/#{sitename}.conf"
  not_if { File.symlink?("/etc/httpd/sites-enabled/#{sitename}.conf") }
end
end

file '/etc/httpd/conf/httpd.conf' do
 action :delete
end

template '/etc/httpd/conf/httpd.conf' do
 source 'httpd.conf.erb'
 action :create
end

service 'httpd' do
 action :restart
end
