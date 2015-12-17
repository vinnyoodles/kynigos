require 'snoo'
class Kynigos

  attr_reader :username, :password, :client
  def initialize(params)
    @username = params.fetch(:username)
    @password = params.fetch(:password)
    @client = Snoo::Client.new
  end

  def login
    client.log_in username, password
  end

  def send(to, title, body)
    client.send_pm to, title, body
  end
end

