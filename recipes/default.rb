#
# Cookbook Name:: zookeeper_smartos
# Recipe:: default
#
# Copyright 2013, HiganWorks LLC
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

file "#{node['zookeeper']['basepath']}/.dlj_license_accepted" do
  action :create_if_missing
  mode "0644"
end

package "zookeeper-server" do
  action :install
  version "3.4.3"
end

service "zookeeper" do
  action :enable
  restart_command "svcadm restart zookeeper"
end

## Must set myid to attribute around each nodes.
unless node['zookeeper']['config'][''].empty?
  raise "Must set attribute myid!!" if node['zookeeper']['config']['myid'] == 0
  file "/var/db/zookeeper/myid" do
    owner "zookeeper"
    group "hadoop"
    content node['zookeeper']['config']['myid']
  end
end

template "#{node['zookeeper']['basepath']}/etc/zookeeper/zoo.cfg" do
  source "zoo.cfg.erb"
  variables node['zookeeper']['config']
  notifies :restart, "service[zookeeper]"
end

