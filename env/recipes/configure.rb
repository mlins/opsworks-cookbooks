node[:deploy].each do |application, deploy|
  execute "restart Rails app #{application}" do
    cwd deploy[:current_path]
    command node[:opsworks][:rails_stack][:restart_command]
    action :nothing
  end

  template "#{deploy[:deploy_to]}/shared/config/application.yml" do
    source 'application.yml.erb'
    owner deploy[:user]
    group deploy[:group]
    mode '0660'
    variables env: node[:env][application]
    notifies :run, "execute[restart Rails app #{application}]"

    only_if do
      File.exists?("#{deploy[:deploy_to]}/shared/config")
    end
  end
end
