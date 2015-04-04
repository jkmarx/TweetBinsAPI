require 'rails_helper'
require 'spec_helper'
require 'net/http'
require 'uri'
require File.join(Rails.root, "lib/modules/OAuth.rb")

describe OAuth do
  let(:callback) {'http://localhost:3000/users/jenniferkmarx'}
  let(:timestamp) {'1428075243'}
  let(:nonce) {'123fbf6cc3464a488eaee4e105253f75'}
  let(:request_params) {
      {
        oauth_callback: "#{callback}",
        oauth_consumer_key: "#{ENV['TWITTER_CONSUMER_KEY']}",
        oauth_nonce: "#{nonce}",
        oauth_signature_method: "HMAC-SHA1",
        oauth_timestamp: "#{timestamp}",
        oauth_version: "1.0"
      }
    }
  let(:access_params) {
    {
      oauth_consumer_key: "#{ENV['TWITTER_CONSUMER_KEY']}",
      oauth_nonce: "#{nonce}",
      oauth_signature_method: "HMAC-SHA1",
      oauth_timestamp: "#{timestamp}",
      oauth_version: "1.0"
    }
  }
  describe 'OAuth::get_base_url' do
    it 'returns the base url for requesting a twitter request_token' do
      expect(OAuth::get_base_url('request_token')).to eq "https://api.twitter.com/oauth/request_token"
      expect(OAuth::get_base_url('access_token')).to eq "https://api.twitter.com/oauth/access_token"
    end
  end

  describe 'OAuth::url_encode' do
    it 'encodes the string' do
      expect(OAuth::url_encode("http://localhost:3000/users/jenniferkmarx")).to eq "http%3A%2F%2Flocalhost%3A3000%2Fusers%2Fjenniferkmarx"
    end
  end

  describe 'OAuth::collect_parameters' do
    it 'returns the base string of all the parameters' do
      expect(OAuth::collect_parameters(request_params).class).to be String
      expect(OAuth::collect_parameters(request_params)).to eq "oauth_callback=http%3A%2F%2Flocalhost%3A3000%2Fusers%2Fjenniferkmarx&oauth_consumer_key=B0QBJGLd6NeHMrOHATSm5luAF&oauth_nonce=123fbf6cc3464a488eaee4e105253f75&oauth_signature_method=HMAC-SHA1&oauth_timestamp=1428075243&oauth_version=1.0"
    end
  end

  describe 'OAuth::get_signature_base_string' do
    it 'should percent encode the base string and the params hash' do
      expect(OAuth::get_signature_base_string('request_token',request_params)).to eq "POST&https%3A%2F%2Fapi.twitter.com%2Foauth%2Frequest_token&oauth_callback%3Dhttp%253A%252F%252Flocalhost%253A3000%252Fusers%252Fjenniferkmarx%26oauth_consumer_key%3DB0QBJGLd6NeHMrOHATSm5luAF%26oauth_nonce%3D123fbf6cc3464a488eaee4e105253f75%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1428075243%26oauth_version%3D1.0"
      expect(OAuth::get_signature_base_string('access_token',access_params)).to eq "POST&https%3A%2F%2Fapi.twitter.com%2Foauth%2Faccess_token&oauth_consumer_key%3DB0QBJGLd6NeHMrOHATSm5luAF%26oauth_nonce%3D123fbf6cc3464a488eaee4e105253f75%26oauth_signature_method%3DHMAC-SHA1%26oauth_timestamp%3D1428075243%26oauth_version%3D1.0"
    end
  end

    describe 'OAuth::create_signature' do
      it 'returns Base64 encoded signature' do
        expect(OAuth::create_signature('request_token',request_params)).to eq 'JZ3aPJcZEwE5qUUgqvd72UK0Lfo='
      end
    end

    describe 'OAuth::add_signature_to_params' do
      it 'appends a key/value pair to the params hash' do
        OAuth::add_signature_to_params(request_params,OAuth::create_signature('request_token',request_params))
        expect(request_params[:oauth_signature]).not_to be nil
        expect(request_params[:oauth_signature]).to eq 'JZ3aPJcZEwE5qUUgqvd72UK0Lfo='
        expect(request_params.length).to eq 7
      end
    end

    describe 'OAuth::get_header_string' do
      it 'converts a hash to a string' do
        expect(OAuth::get_header_string('request_token',request_params)).to eq "OAuth oauth_callback=\"http%3A%2F%2Flocalhost%3A3000%2Fusers%2Fjenniferkmarx\", oauth_consumer_key=\"B0QBJGLd6NeHMrOHATSm5luAF\", oauth_nonce=\"123fbf6cc3464a488eaee4e105253f75\", oauth_signature=\"JZ3aPJcZEwE5qUUgqvd72UK0Lfo%3D\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"1428075243\", oauth_version=\"1.0\""
      end
    end
  end

