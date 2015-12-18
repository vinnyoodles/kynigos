require "bundler/gem_tasks"

task :send_prize do 
  require 'kynigos'
  Kynigos.new(username: ENV["REDDIT_USERNAME"], password: ENV["REDDIT_PASSWORD"]).
    send_prize 'vinnyoodles', 'Clarence', 'weightlifting'
end

task :default => :send_prize
