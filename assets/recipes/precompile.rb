node[:deploy].each do |application, deploy|
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
