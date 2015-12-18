require "bundler/gem_tasks"

task :send_prize do 
  require 'kynigos'
  require 'yaml'
  keywords = YAML.load_file('lib/keywords.yml')["keywords"]
  Kynigos.new(username: ENV["REDDIT_USERNAME"], password: ENV["REDDIT_PASSWORD"]).
    send_prize 'vinnyoodles', keywords, 'weightlifting'
end

task :default => :send_prize
