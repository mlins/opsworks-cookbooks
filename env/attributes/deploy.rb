node[:deploy].each do |application, deploy|
  default[:deploy][application][:symlink_before_migrate]['config/application.yml'] = 'config/application.yml'
end
