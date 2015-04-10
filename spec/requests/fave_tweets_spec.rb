require 'rails_helper'

RSpec.describe "FaveTweets", :type => :request do
  describe "GET /fave_tweets" do
    it "works! (now write some real specs)" do
      get fave_tweets_path
      expect(response).to have_http_status(200)
    end
  end
end
