#
# Cookbook Name:: riak-cs
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
bash "install_riak_cs_from_packagecloud" do
  code <<-EOH
  curl -s https://packagecloud.io/install/repositories/basho/riak-cs/script.rpm.sh | bash
  yum install riak-cs-#{node['riak-cs']['major_number']}.#{node['riak-cs']['minor_number']}.#{node['riak-cs']['incremental']}-#{node['riak-cs']['build']}.el7.centos.x86_64
  EOH
  not_if "which riak-cs"
end

template "/etc/riak-cs/riak-cs.conf" do
  source
  owner 'root'
  group 'root'
  mode '0644'
  variables({
    :ip => node['ipaddress'],
    :admin_key => node['riak-cs']['admin_key'],
    :admin_secret => node['riak-cs']['admin_secret']
  })
end
