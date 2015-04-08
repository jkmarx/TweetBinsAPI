class Tweet
  include ActiveModel::Model

  attr_accessor :tweets

  def self.filterTweets(data)
    data.map{|tweet|
      {
        userScreen: getScreenname(tweet),
        text: getText(tweet),
        created_at: getCreatedAt(tweet)
      }
    }
  end

  def self.getScreenname(string)
    string["user"]["screen_name"]
  end

  def self.getText(string)
    string["text"]
  end

  def self.getCreatedAt(string)
    string["created_at"]
  end

end
