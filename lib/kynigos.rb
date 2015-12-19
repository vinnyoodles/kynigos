require 'snoo'
class Kynigos

  attr_reader :username, :password, :client
  def initialize(params)
    @username = params.fetch(:username)
    @password = params.fetch(:password)
    @client = Snoo::Client.new
    client.log_in username, password
  end

  #send a message to specified reddit user with urls of
  #specific listings that match the specified keywords
  #@params to => reddit user
  #@params keywords => array of words to search for
  #@params sub => subreddit to search in
  def send_prize to, keywords, sub
    client.send_pm to, title, format_body(keywords, sub)
  end

  def title
    "Hunt from #{Time.now.strftime("%b. %e, %Y %I:%M%p %Z")}"
  end

  #return the past 100 listings in the subreddit
  #@params sub => subreddit
  def get_listings sub
    client.get_listing({
      subreddit: sub,
      page:      'new',
      limit:     100
    })
  end

  #return title and url of listings in subreddit
  #@params sub => subreddit
  def clean_up_listings sub
    get_listings(sub)["data"]["children"].map do |listing|
      {
        title: listing["data"]["title"],
        url:   listing["data"]["permalink"]
      }
    end
  end

  #search through listings in subreddit for keywords
  #return listings with keywords
  #@params words => keywords
  #@params sub => subreddit
  def hunt_for words, sub
    clean_up_listings(sub).select do |title|
      title if words.map do |word|
        title[:title].include?(word)
      end.include? true
    end
  end

  #return urls of listings after search
  #@params keywords => keywords
  #@params sub => subreddit
  def format_body keywords, sub
    words = [keywords.map(&:split)].flatten
    hunt_for(words, sub).map do |prize|
      prize[:url]
    end.join("\n")
  end

end
