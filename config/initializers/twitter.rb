Twitter.configure do |cnf|
  cnf.consumer_key = ENV['TWITTER_CONSUMER_KEY']
  cnf.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
  cnf.oauth_token = ENV['TWITTER_TOKEN']
  cnf.oauth_token_secret = ENV['TWITTER_TOKEN_SECRET']
end
