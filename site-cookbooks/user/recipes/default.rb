#
# Cookbook:: user
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

group 'dev' do
  group_name 'dev'
  action :create
end


user 'Add a company' do
  home '/home/company'
  shell '/bin/bash'
  username 'company'
  group 'dev'
  manage_home true
  password '$1$FwMuX7tH$qRDlX18npy8VoBSRBD9.K1' # 123456
  action :create
end

user 'Add a personal' do
  home '/home/quocdt'
  shell '/bin/bash'
  manage_home true
  group 'dev'
  username 'quocdt'
  password '$1$FwMuX7tH$qRDlX18npy8VoBSRBD9.K1' # 123456
  action :create
end

%w(quocdt company).each do |user|
  directory "/home/#{user}" do
    owner user
    group 'dev'
    mode '0755'
    action :create
  end
end
