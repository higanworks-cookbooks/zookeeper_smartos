node.default['zookeeper']['basepath'] = "/opt/local"
node.default['zookeeper']['config'] = {
  :datadir => "/var/db/zookeeper",
  :clientport => 2181,
  :clientport_address => nil,
  :ap_snapretaincount => 3,
  :ap_purgeinterval => 2,
  :cluster_servers => [],
  :myid => 0
}


## Example for Cluster
# cluster_servers = ["1=zoo1:2888:3888","2=zoo2:2888:3888","3=zoo3:2888:3888"]
# and set numeric id to node['zookeeper']['config']['myid'] at each servers own attribute.
