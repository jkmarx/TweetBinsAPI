module OAuth
  require 'net/http'

  def self.get_base_url(token_type)
    "https://api.twitter.com/oauth/#{token_type}"
  end

  # http://ruby-doc.org/stdlib-1.9.3/libdoc/cgi/rdoc/CGI.html
  def self.url_encode(url)
    CGI::escape(url)
  end

  def self.get_signature_base_string(param_url, param_hash)
      'POST' + "&" + OAuth::url_encode(OAuth::get_base_url(param_url)) + "&" + OAuth::url_encode(OAuth::collect_parameters(param_hash))
  end

  def self.create_signature(param_url, param_hash)
    Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha1'), OAuth::url_encode(ENV['TWITTER_CONSUMER_SECRET']) + "&", OAuth::get_signature_base_string(param_url,param_hash))).gsub(/\n| |\r/,'')
  end

  def self.add_signature_to_params(hash,value)
    hash[:oauth_signature] = value
    hash
  end

  def self.get_header_string(param_url, param_hash)
    hash = OAuth::add_signature_to_params(param_hash,OAuth::create_signature(param_url,param_hash))
    header = "OAuth "
    hash.sort.each do |k,v|
      header << "#{k}=\"#{OAuth::url_encode(v)}\", "
    end
    header.slice(0..-3)
  end


  def self.collect_parameters(hash)
    hash.sort.collect{ |k, v| "#{OAuth::url_encode(k.to_s)}=#{OAuth::url_encode(v)}" }.join('&')
  end

  class RequestToken
    attr_accessor :consumer_key, :consumer_secret, :base_url, :timestamp, :callback, :params

    def initialize()
      @consumer_key = ENV['TWITTER_CONSUMER_KEY']
      @consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      @timestamp = Time.now.utc.to_i.to_s
      @callback = 'http://localhost:3000/callbacks/twitter'
      @params = {
        oauth_callback: "#{@callback}",
        oauth_consumer_key: "#{ENV['TWITTER_CONSUMER_KEY']}",
        oauth_nonce: "#{SecureRandom.uuid.gsub(/\-|\n|\r/,'')}",
        oauth_signature_method: "HMAC-SHA1",
        oauth_timestamp: "#{@timestamp}",
        oauth_version: "1.0"
      }
    end
    def request_data(header, base_uri, method, post_data=nil)
      url = URI.parse(base_uri)
      http = Net::HTTP.new(url.host, 443)
      http.use_ssl = true
      if method == 'POST'
        response, data = http.post(base_uri, post_data, { 'Content-Type'=> '', 'Authorization' => header })
      else
        response, data = http.get(url.to_s, { 'Authorization' => header })
      end
    end
  end

  class AccessToken
    attr_accessor :data, :params

    def initialize(data)
      @consumer_key = ENV['TWITTER_CONSUMER_KEY']
      @consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      @timestamp = Time.now.utc.to_i.to_s
      @data = data
      @params = {
        oauth_consumer_key: "#{ENV['TWITTER_CONSUMER_KEY']}",
        oauth_nonce: "#{SecureRandom.uuid.gsub(/\-|\n|\r/,'')}",
        oauth_signature_method: "HMAC-SHA1",
        oauth_timestamp: "#{@timestamp}",
        oauth_version: "1.0"
      }
    end

    def request_data(header, base_uri, method, post_data=nil)
      url = URI.parse(base_uri)
      http = Net::HTTP.new(url.host, 443)
      http.use_ssl = true
      if method == 'POST'
        response, data = http.post(base_uri, post_data[:params], { 'Content-Type'=> '', 'Authorization' => header })
      else
        response, data = http.get(url.to_s, { 'Authorization' => header })
      end
      response
    end
  end
end
