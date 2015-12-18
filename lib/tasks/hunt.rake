desc "Find listings in r/weightlifting with keywords"
  task :send do 
    require 'kynigos'
    require 'yaml'
    keywords = YAML.load_file('lib/keywords.yml')["keywords"]
    Kynigos.new(username: ENV["REDDIT_USERNAME"], password: ENV["REDDIT_PASSWORD"]).
      send_prize 'vinnyoodles', keywords, 'weightlifting'
  end
