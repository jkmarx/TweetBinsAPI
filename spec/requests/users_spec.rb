require 'rails_helper'

describe 'User request' do
  before(:all) do
    User.destroy_all
    @users = User.all
    @user = User.create!(twitterUsername: "jenniferkmarx")
  end

  describe '#index' do
    it 'gets all of the users' do
      get '/users'
      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json.length).to eq 1
    end
  end

  describe '#create' do
    it 'should create a new movie and return it' do
      post '/users',
      { user: {
          twitterUsername: "rockStar"
        } }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

      user = JSON.parse(response.body)
      expect(user['twitterUsername']).to eq "rockStar"
    end
  end

   describe '#show' do
    it 'should retrieve a single user by id and return json' do
      get "/users/#{@user.id}"
      expect(response).to be_success

      user = JSON.parse(response.body)
      expect(user['twitterUsername']).to eq @user.twitterUsername
    end
  end

  describe '#update' do
    it 'should update a user twitter name do' do
      put "/users/#{@user.id}",
      { user: {
          twitterUsername: "danceStar"
        }
      }.to_json,
      { 'Accept' => Mime::JSON, 'Content-Type' => Mime::JSON.to_s }

      expect(response).to be_success
      expect(response.content_type).to be Mime::JSON

      user = JSON.parse(response.body)
      expect(user['twitterUsername']).to eq "danceStar"
    end
  end

  describe '#destroy' do
    it 'should remove the user' do
      user = @users.first
      delete "/users/#{user.id}"
      expect(response.status).to eq 204
    end
  end

end
