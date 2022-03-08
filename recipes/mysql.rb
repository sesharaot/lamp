#
# Cookbook:: lamp
# Recipe:: mysql
#
# Copyright:: 2022, The Authors, All Rights Reserved.

package 'mariadb'
package 'mariadb-server'

service 'mariadb' do
  action [ :enable, :start ]
end

#execute 'mysql user update' do
#  user 'root'
#  command <<-EOH
# mysql -u root
# UPDATE mysql.user SET Password=PASSWORD(login321) WHERE User='root';
# FLUSH PRIVILEGES;
# quit;
# EOH
# not_if
#end

bash 'mysql_secure_install_automate' do
user 'root'
cwd 'root'
code <<-EOH
mysql -uroot <<-EOF
UPDATE mysql.user SET Password=PASSWORD('login321') WHERE User='root';
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
FLUSH PRIVILEGES;
EOF
if [ $? -eq 0 ]; then
  echo success
else 
  echo FAIL
fi
EOH
end


service 'mariadb' do
  action :restart
end
