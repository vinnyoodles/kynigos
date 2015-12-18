require "bundler/gem_tasks"
require 'Kynigos'

task :send_prize do 
  Kynigos.new(username: ENV["REDDIT_USERNAME"], password: ENV["REDDIT_PASSWORD"]).
    send_prize 'vinnyoodles', 'Clarence', 'weightlifting'
end

task :default => :send_prize
