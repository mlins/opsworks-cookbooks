node[:deploy].each do |application, deploy|
  default[:deploy][application][:symlink_before_migrate]["assets"] = "public/assets"
end
