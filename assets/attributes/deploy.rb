node[:deploy].each do |application, deploy|
  default[:deploy][application][:symlink_before_migrate]['cache'] = 'tmp/cache'
end
