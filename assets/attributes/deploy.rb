node[:deploy].each do |application, deploy|
  default[:deploy][application][:symlink_before_migrate]['cache'] = 'tmp/cache'
  default[:deploy][application][:symlink_before_migrate]['assets'] = 'public/assets'
end
