#
# Cookbook:: lamp
# Recipe:: httpd
#
# Copyright:: 2022, The Authors, All Rights Reserved.

execute 'epel repo conf' do
 command 'sudo yum install epel-release -y'
end

package 'httpd' do
 action :install
end

service 'httpd' do
  action [ :enable , :start ]
end
