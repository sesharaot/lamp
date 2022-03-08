#
# Cookbook:: lamp
# Spec:: httpd
#
# Copyright:: 2022, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'lamp::httpd' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end


    it 'installs the correct package' do
      expect(chef_run).to install_package('httpd')
    end

    it 'starts the service' do
      expect(chef_run).to start_service('httpd')
    end

    it 'enables the service' do
      expect(chef_run).to enable_service('httpd')
    end
  end
end
