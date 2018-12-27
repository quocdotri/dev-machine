#
# Cookbook:: custom-lib
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# imagemagick
%w(exuberant-ctags libjpeg-dev libpng-dev imagemagick libmagickcore-dev libmagickwand-dev).each do |pkg|
  package pkg do
    action :install
  end
end

["quocdt", "company"].each do |user|
  %w(.bash_profile).each do |file|
    cookbook_file "/home/#{user}/#{file}" do
      owner user
      group 'dev'
      mode '0644'
    end
  end
end
