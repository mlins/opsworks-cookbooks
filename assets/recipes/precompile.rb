node[:deploy].each do |application, deploy|
  directory "#{deploy[:deploy_to]}/shared/assets" do
    group params[:group]
    owner params[:user]
    mode 0770
    action :create
    recursive true
  end

  execute "precompile assets for Rails app #{application}" do
    cwd deploy[:current_path]
    command "bundle exec rake assets:precompile"
    environment ({
      "RAILS_ENV" => deploy[:rails_env],
      "SECRET_KEY_BASE" => "devise-needs-this"
    })
  end

  execute "clean assets for Rails app #{application}" do
    cwd deploy[:current_path]
    command "bundle exec rake assets:clean[5]"
    environment ({
      "RAILS_ENV" => deploy[:rails_env],
      "SECRET_KEY_BASE" => "devise-needs-this"
    })
  end
end
