set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :application, 'quesabes'
set :app_branch, "master"
set :theme, "quesabes-theme"

namespace :app do
  desc "Update app code"
  task :update_code do
    run "cd #{deploy_to} && git pull origin #{app_branch}"
  end

  desc "Update theme"
  task :update_theme do
    run "cd #{File.join(deploy_to,'vendor','plugins',theme)} && git pull origin master"
  end

  desc "Touch restart.txt to reload app"
  task :reload do
    run "touch #{File.join(deploy_to,'tmp','restart.txt')}"
  end

  desc "Update the whole thing"
  task :update do
    update_theme
    update_code
    reload
  end
end

desc "Update locales from Transifex"
namespace :update_tx do
  task :default do
    es
    app::reload
  end

  desc "Update Spanish locale"
  task :es do
    run "cd #{deploy_to} && tx pull -l es -f"
  end

end
