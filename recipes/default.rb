#
# Cookbook:: lamp
# Recipe:: default
#
# Copyright:: 2022, The Authors, All Rights Reserved.

include_recipe 'lamp::httpd'
include_recipe 'lamp::php'
include_recipe 'lamp::multisites'
include_recipe 'lamp::mysql'
