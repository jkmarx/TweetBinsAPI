class Follower < ActiveRecord::Base
  belongs_to :category

  attr_accessor :followerIds

  def self.filterTweets(data)
    JSON.parse(data)["ids"]
  end

end
