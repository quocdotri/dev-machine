#
# Cookbook:: vim-plugin
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.
#

# for neocomplete https://github.com/Shougo/neocomplete.vim
package 'vim-nox' do
  action :install
  retries 5
end

node['vim_users'].each do |user|
  directory "/home/#{user}/.vim" do
    owner user
    group 'dev'
    mode '0755'
    action :create
  end

  %w(backup bundle swap).each do |dir|
    directory "/home/#{user}/.vim/#{dir}" do
      owner user
      group 'dev'
      mode '0755'
      action :create
    end
  end

  execute 'install neobundle' do
    user user
    group 'dev'
    cwd "/home/#{user}"
    command 'curl -L https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh'
    environment 'HOME' => "/home/#{user}"
    not_if { File.exists?("/home/#{user}/.vim/bundle/neobundle.vim") }
  end

  %w(.vimrc).each do |file|
    cookbook_file "/home/#{user}/#{file}" do
      owner user
      group 'dev'
      mode '0644'
    end
  end
end
