require 'httparty'
require 'open-uri'
require 'pp'
require 'json'
module MultiShorten

  class Client

    def initialize
    end
    
  end

  class UrlShortener
    include HTTParty

    def shorten url
    end

    def fail
      { :status => :fail }
    end

  end

  class B54 < UrlShortener

    base_uri "http://b54.in"
    format :json

    def shorten url
      response = B54.get "/api", :query => {:action => "shorturl", :url => URI.encode(url), :format => "json"} rescue return fail
      if response["shorturl"]
        {:status => :success, :short_url => URI.unescape(response["shorturl"])}
      else
        fail
      end
    end

  end

  class Linkee < UrlShortener
    base_uri "http://api.linkee.com"
    format :json
    def shorten url
      response = Linkee.get "/1.0/shorten", :query => {:input => URI.encode(url)}
      if response["status"]["code"] == 200
        {:status => :success, :short_url => response["result"]}
      else
        {:status => :fail}
      end
    end
  end

  class Celly < UrlShortener
    base_uri "http://celly.co.il"
    format :json
    def shorten url
      response = Celly.get "/api/get", :query => {:url => URI.encode(url), :type => "json"}
      if response.parsed_response["success"] == true
        { :status => :success, :short_url => response.parsed_response["data"]["url"] }
      else
        fail
      end
    end
  end  

  class Googl < UrlShortener
    base_uri "https://www.googleapis.com/urlshortener"
    format :json
    def shorten url
      response = Googl.post "/v1/url", :headers => {"Content-Type" => "application/json"}, :body => JSON.dump({:longUrl => URI.encode(url)})
      unless response.parsed_response["id"].nil?
        { :status => :success, :short_url => response.parsed_response["id"] }
      else
        fail
      end
    end
  end

  class IsGd < UrlShortener
    base_uri "http://is.gd/"
    format :json
    def shorten url
      response = IsGd.get "/create.php", :query => {:format => "json", :url => URI.encode(url)}
      unless response.parsed_response["shorturl"].nil?
        { :status => :success, :short_url => response.parsed_response["shorturl"] }
      else
        fail
      end
    end
  end

  class JumboTweet < UrlShortener
    base_uri "http://jmb.tw"
    format :plain
    def shorten url
      response = JumboTweet.get "/api/create", :query => { :newurl => URI.encode(url)}
      if response.match("^http://jmb.tw/.+")
        { :status => :success, :short_url => response }
      else
        fail
      end
    end
  end

  class MetaMark < UrlShortener
    base_uri "http://metamark.net"
    format :plain
    def shorten url
      response = MetaMark.get "/api/rest/simple", :query => { :long_url => URI.encode(url)}
      if response.match("^http://xrl.us/.+")
        { :status => :success, :short_url => response }
      else
        fail
      end
    end
  end

  class MtNy < UrlShortener
    base_uri "http://mtny.mobi"
    format :json
    def shorten url
      response = MtNy.get "/api", :query => {:type => "json", :source => "web", :url => URI.encode(url)}
      unless response.parsed_response["url"].nil?
        { :status => :success, :short_url => response.parsed_response["url"] }
      else
        fail
      end
    end
  end

  class QrCx < UrlShortener
    base_uri "http://qr.cx"
    format :plain

    def shorten url
      response = QrCx.get "/api/?", :query => {:longurl => URI.encode(url)}
      if response.match("^http://qr.cx/.+")
        { :status => :success, :short_url => response }
      else
        fail
      end
    end

  end

  class Shortr < UrlShortener
    base_uri "http://shortr.info"
    format :json
    def shorten url
      response = Shortr.get "/make-shortr.php", :query => {:format => "json", :url => URI.encode(url)}
      unless response.parsed_response["shortr"]["result"]["created"].nil?
        { :status => :success, :short_url => response.parsed_response["shortr"]["result"]["created"] }
      else
        fail
      end
    end
  end
  
end
