desc "This task is called by the Heroku scheduler add-on"
task :update_status => :environment do
  User.update_all(status: true, online: false)
end

