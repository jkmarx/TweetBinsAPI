class Tweet < ActiveModel::Model

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

  def getText(string)
    string["text"]
  end

  def getCreatedAt(string)
    string["created_at"]
  end

end
