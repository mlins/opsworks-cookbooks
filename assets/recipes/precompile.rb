node[:deploy].each do |application, deploy|
  before_symlink do
    directory "#{deploy[:deploy_to]}/shared/cache" do
      owner 'deploy'
      group 'www-data'
      mode '0770'
      action :create
    end

    directory "#{deploy[:deploy_to]}/shared/assets" do
      owner 'deploy'
      group 'www-data'
      mode '0770'
      action :create
    end
  end

  before_restart do
    execute "precompile assets for Rails app #{application}" do
      cwd deploy[:current_path]
      command 'bundle exec rake assets:precompile'
      environment 'RAILS_ENV' => deploy[:rails_env]
    end

    execute "cleanup assets for Rails app #{application}" do
      cwd deploy[:current_path]
      command 'bundle exec rake assets:cleanup[5]'
      environment 'RAILS_ENV' => deploy[:rails_env]
    end
  end
end
