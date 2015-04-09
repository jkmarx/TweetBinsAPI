class Friend < ActiveRecord::Base
  belongs_to :category

  attr_accessor :friendIds

  def self.filterTweets(data)
    JSON.parse(data)["ids"]
  end

end
