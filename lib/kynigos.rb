require 'net/http'
require 'json'
class Kynigos

  attr_reader :username, :password, :modhash, :access_token
  def initialize(params)
    @username = params.fetch(:username, nil)
    @password = params.fetch(:password, nil)
    authenticate!
    log_in if @username && @password
  end

  #send a message to specified reddit user with urls of
  #specific listings that match the specified keywords
  #@params to => reddit user
  #@params keywords => array of words to search for
  #@params sub => subreddit to search in
  def send_prize to, keywords, sub
    message to, title, format_body(keywords, sub) if access_token
  end

  #return title and url of listings in subreddit
  #@params sub => subreddit
  def clean_up_listings sub
    get_listings(sub)["data"]["children"].map do |listing|
      {
        title:   listing["data"]["title"],
        flair:   listing["data"]["link_flair_text"],
        text:    listing["data"]["selftext"],
        thumbs:  listing["data"]["ups"],
        url:     listing["data"]["permalink"]
      }
    end
  end

  #search through listings in subreddit for keywords
  #return listings with keywords
  #@params words => keywords
  #@params sub => subreddit
  def hunt_for words, sub
    clean_up_listings(sub).select do |title|
      title if title[:thumbs] > 20 ||
      title if words.map do |word|
        concat = title.values.join(" ")
        concat.include?(word)
      end.any?
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

  private

  #return the past 100 listings in the subreddit
  #through reddit's api
  #@params sub => subreddit
  def get_listings sub
    uri = URI("#{base_uri}/r/#{sub}/new.json")
    params = { limit: 100 }
    uri.query = URI.encode_www_form(params)
    JSON.parse(Net::HTTP.get_response(uri).body)
  end

  #log in to reddit through their api
  def log_in
    uri = URI("#{base_uri}/api/login")
    body = {
      user:     @username,
      passwd:   @password,
      api_type: 'json'
    }
    response = Net::HTTP.post_form(uri, body)
    data = JSON.parse(response.body)
    @modhash = data['json']['data']['modhash']
  end

  #send message through reddit's api
  #must be logged in
  #@params to => message recipient
  #@params subject => title of message
  #@params text => message body
  def message to, subject, text
    uri = URI("#{oauth_uri}/api/compose.json")
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Post.new(uri)
      request['Authorization'] = "bearer #{access_token}"
      request.set_form_data(to: to,
                      subject:  subject,
                      text:     text,
                      api_type: 'json',
                      uh:       @modhash)
      http.request(request)
    end
  end

  def authenticate!
    uri = URI("#{base_uri}/api/v1/access_token")
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Post.new(uri)
      request.basic_auth ENV["REDDIT_CLIENT_ID"], ENV["REDDIT_SECRET"]
      request.set_form_data(grant_type: 'password',
                            username:   @username,
                            password:   @password)
      http.request(request)
    end
    @access_token = JSON.parse(response.body)["access_token"]
  end

  #return reddits base uri
  def base_uri
    "https://www.reddit.com"
  end

  def oauth_uri
    "https://oauth.reddit.com"
  end

  #format title of message as timestamp
  def title
    "Hunt from #{Time.now.strftime("%b. %e, %Y %I:%M%p %Z")}"
  end


end
