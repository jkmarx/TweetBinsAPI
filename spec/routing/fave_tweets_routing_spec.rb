require "rails_helper"

RSpec.describe FaveTweetsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/fave_tweets").to route_to("fave_tweets#index")
    end

    it "routes to #new" do
      expect(:get => "/fave_tweets/new").to route_to("fave_tweets#new")
    end

    it "routes to #show" do
      expect(:get => "/fave_tweets/1").to route_to("fave_tweets#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/fave_tweets/1/edit").to route_to("fave_tweets#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/fave_tweets").to route_to("fave_tweets#create")
    end

    it "routes to #update" do
      expect(:put => "/fave_tweets/1").to route_to("fave_tweets#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/fave_tweets/1").to route_to("fave_tweets#destroy", :id => "1")
    end

  end
end
