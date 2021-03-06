require 'rails_helper'
require 'spec_helper'
require 'net/http'
require 'uri'
require File.join(Rails.root, "lib/modules/TweetAuth.rb")

# describe TweetAuth do
#   let(:timestamp) {'1428415488'}
#   let(:nonce) {'3a316d8038824b10b3fd2ac051d2ba9b'}
#   let(:tokenSecret){'J6zix3FfA9LofH0awS24M3HcBYXO5nI1iYe8EfBA'}
#   let(:request_params) {
#       {
#         oauth_consumer_key: "B0QBJGLd6NeHMrOHATSm5luAF",
#         oauth_nonce: "#{nonce}",
#         oauth_signature_method: "HMAC-SHA1",
#         oauth_timestamp: "#{timestamp}",
#         oauth_token: "2993886084-58xam6y3NipJl9X3aKm2F6tEDDihv5BK7sbS6bZ",
#         oauth_version: "1.0"
#       }
#     }

#   describe 'Tweets::get_base_url' do
#     it 'returns the base url for requesting tweets' do
#       expect(TweetAuth::get_base_url('tweets')).to eq "https://api.twitter.com/1.1/statuses/home_timeline.json"
#     end
#   end

#   describe 'TweetAuth::url_encode' do
#     it 'encodes the string' do
#       expect(TweetAuth::url_encode("http://localhost:3000/users/jenniferkmarx")).to eq "http%3A%2F%2Flocalhost%3A3000%2Fusers%2Fjenniferkmarx"
#     end
#   end



#   describe 'TweetAuth::create_signature' do
#     it 'returns Base64 encoded signature, tweets' do
#       expect(TweetAuth::create_signature(tokenSecret,request_params,'tweets')).to eq 'QY0TKyp8bTeHgWex/qOl3zFSMsA='
#     end
#   end

#   describe 'TweetAuth::get_header_string' do
#     it 'converts a hash to a string, tweets' do
#       expect(TweetAuth::get_header_string(tokenSecret,request_params,'tweets')).to eq "OAuth oauth_consumer_key=\"B0QBJGLd6NeHMrOHATSm5luAF\", oauth_nonce=\"3a316d8038824b10b3fd2ac051d2ba9b\", oauth_signature=\"QY0TKyp8bTeHgWex%2FqOl3zFSMsA%3D\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"1428415488\", oauth_token=\"2993886084-58xam6y3NipJl9X3aKm2F6tEDDihv5BK7sbS6bZ\", oauth_version=\"1.0\""
#     end
#   end
# end

  #Testing purpose, hardcodes create_signature
  # def self.create_signature(tokenSecret, param_hash)
  #   Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha1'), Tweets::url_encode('MCD8BKwGdgPHvAuvgvz4EQpqDAtx89grbuNMRd7Eh98') + "&#{tokenSecret}", Tweets::get_signature_base_string(param_hash))).gsub(/\n| |\r/,'')
  # end

# describe TweetAuth do
# let(:timestamp) {'1428519062'}
# let(:nonce) {'a22d5f6d982e4e0a88540ba47424da6c'}
# let(:tokenSecret){'J6zix3FfA9LofH0awS24M3HcBYXO5nI1iYe8EfBA'}
# let(:request_params) {
#     {
#       oauth_consumer_key: "fZcUdPbYdkEu64csHixN5dMjM",
#       oauth_nonce: "#{nonce}",
#       oauth_signature_method: "HMAC-SHA1",
#       oauth_timestamp: "#{timestamp}",
#       oauth_token: "2993886084-gXAyKxFEm8TjcKNFx0zVwD1b3UhPxeRqdSYRSBO",
#       oauth_version: "1.0"
#     }
#   }

#   describe 'TweetAuth::create_signature' do
#     it 'returns Base64 encoded signature' do
#       expect(TweetAuth::create_signature(tokenSecret,request_params,'followers',"%26screen_name%3Djenniferkmarx")).to eq 'tEjZsv/kIrZCqoThJ2gYwCDEgdA='
#     end
#   end

#   describe 'TweetAuth::get_header_string' do
#     it 'converts a hash to a string' do
#       expect(TweetAuth::get_header_string(tokenSecret,request_params,'followers', "%26screen_name%3Djenniferkmarx")).to eq "OAuth oauth_consumer_key=\"fZcUdPbYdkEu64csHixN5dMjM\", oauth_nonce=\"a22d5f6d982e4e0a88540ba47424da6c\", oauth_signature=\"tEjZsv%2FkIrZCqoThJ2gYwCDEgdA%3D\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"1428519062\", oauth_token=\"2993886084-gXAyKxFEm8TjcKNFx0zVwD1b3UhPxeRqdSYRSBO\", oauth_version=\"1.0\""
#     end
#   end
# end


describe TweetAuth do
  let(:timestamp) {'1428553259'}
  let(:nonce) {'ffdc6d7958374bc6a40771d241227be7'}
  let(:tokenSecret){'J6zix3FfA9LofH0awS24M3HcBYXO5nI1iYe8EfBA'}
  let(:request_params) {
      {
        oauth_consumer_key: "fZcUdPbYdkEu64csHixN5dMjM",
        oauth_nonce: "#{nonce}",
        oauth_signature_method: "HMAC-SHA1",
        oauth_timestamp: "#{timestamp}",
        oauth_token: "2993886084-gXAyKxFEm8TjcKNFx0zVwD1b3UhPxeRqdSYRSBO",
        oauth_version: "1.0"
      }
    }


  describe 'TweetAuth::create_signature' do
    it 'returns Base64 encoded signature, tweets' do
      expect(TweetAuth::create_signature(tokenSecret,request_params,'tweets', "count%3D200%26")).to eq 'P5Fo/gCzwjeaedlqCkgKcB1EJ/g='
    end
  end


  describe 'TweetAuth::get_header_string' do
    it 'converts a hash to a string, tweets' do
      expect(TweetAuth::get_header_string(tokenSecret,request_params,'tweets',"count%3D200%26")).to eq "OAuth oauth_consumer_key=\"fZcUdPbYdkEu64csHixN5dMjM\", oauth_nonce=\"ffdc6d7958374bc6a40771d241227be7\", oauth_signature=\"P5Fo%2FgCzwjeaedlqCkgKcB1EJ%2Fg%3D\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"1428553259\", oauth_token=\"2993886084-gXAyKxFEm8TjcKNFx0zVwD1b3UhPxeRqdSYRSBO\", oauth_version=\"1.0\""
    end
  end
end
