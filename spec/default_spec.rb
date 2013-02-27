require 'chefspec'

describe 'zookeeper_smartos::default' do
  let (:chef_run) { ChefSpec::ChefRunner.new.converge 'zookeeper_smartos::default' }
  it 'should create file .dlj_license_accepted' do
    chef_run.should create_file_with_content '/opt/local/.dlj_license_accepted', ''
  end

  it 'should install zookeeper-server' do
    chef_run.should install_package 'zookeeper-server'
  end

  it 'should create zoo.cfg from template' do
    chef_run.template("/opt/local/etc/zookeeper/zoo.cfg").source.should == "zoo.cfg.erb"
  end

  it 'should start service zookeeper' do
    chef_run.should enable_service "zookeeper"
  end
end
