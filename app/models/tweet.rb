class Tweet
  include ActiveModel::Model

  attr_accessor :tweets

  def self.filterTweets(data)
    JSON.parse(data).map{|tweet|
      {
        userScreenname: getScreenname(tweet),
        text: getText(tweet),
        created_at: getCreatedAt(tweet),
        userId: getUserId(tweet),
        profile_image_url: getProfileImageUrl(tweet)
      }
    }
  end

  def self.getScreenname(string)
    string["user"]["screen_name"]
  end

  def self.getText(string)
    string["text"]
  end

  def self.getProfileImageUrl(string)
    string["user"]["profile_image_url"]
  end

  def self.getCreatedAt(string)
    formatDate(splitString(string["created_at"]))
  end

  def self.formatDate(dateArr)
    arr = [dateArr[0], dateArr[1],dateArr[2], dateArr[5], setEST(dateArr[3])]

    arr.join(' ')
  end

  def self.splitString(str)
    str.split(' ')
  end

  def self.setEST(time)
    timeArr = time.split(':')
    current = timeArr[0].to_i
    if current > 19
      timeArr[0] = (current - 20).to_s
    else
      timeArr[0] = (current - 4 ).to_s
    end
    timeArr.join(':')
  end

  def self.getUserId(string)
    string["user"]["id"]
  end

end
