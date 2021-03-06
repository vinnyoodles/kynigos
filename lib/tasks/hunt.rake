desc "Find listings in r/weightlifting with keywords"

task :setup do
  require 'kynigos'
  require 'yaml'
  @keywords = YAML.load_file('lib/keywords.yml')["keywords"]
  @client = Kynigos.new(username: ENV["REDDIT_USERNAME"], password: ENV["REDDIT_PASSWORD"])
end

task :weightlifting => :setup do 
  @client.send_full_prize 'vinnyoodles', @keywords['weightlifting'], 'weightlifting'
end

task :shokugeki => :setup do 
  @client.send_reduced_prize 'vinnyoodles', @keywords['shokugekinosouma'], 'shokugekinosouma'
end

task :onepiece => :setup do
  @client.send_reduced_prize 'vinnyoodles', @keywords['onepiece'], 'onepiece'
end

task :bleach => :setup do
  @client.send_reduced_prize 'vinnyoodles', @keywords['bleach'], 'bleach'
end
