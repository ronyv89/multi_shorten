require 'httparty'
require 'open-uri'
require 'pp'
require 'json'
# The main MultiShorten module
module MultiShorten

  # Base class from which all other classes are derived
  class UrlShortener
    # HTTPArty is included here so that its appicable to all the sub classes
    include HTTParty

    # Returns shortened version of the url for the corresponding. This is the abstract class
    # @param [String] url the url to be shortened
    # @return [Hash] the resulting hash with status -> either :success or :fail. If success it also includes the :short_url
    def self.shorten url
    end

    # The hash that is returned when there is a failure
    def fail
      { :status => :fail }
    end

  end

  # URL Shortener for B54
  class B54 < UrlShortener

    base_uri "http://b54.in"
    format :json

    def self.shorten url
      response = get "/api", :query => {:action => "shorturl", :url => URI.encode(url), :format => "json"} rescue return fail
      if response["shorturl"]
        {:status => :success, :short_url => URI.unescape(response["shorturl"])}
      else
        fail
      end
    end

  end

  # URL Shortener for Linkee
  class Linkee < UrlShortener
    base_uri "http://api.linkee.com"
    format :json
    def self.shorten url
      response = get "/1.0/shorten", :query => {:input => URI.encode(url)}
      if response["status"]["code"] == 200
        {:status => :success, :short_url => response["result"]}
      else
        {:status => :fail}
      end
    end
  end

  # URL Shortener for goo.gl
  class GooGl < UrlShortener
    base_uri "https://www.googleapis.com/urlshortener"
    format :json
    def self.shorten url
      response = post "/v1/url", :headers => {"Content-Type" => "application/json"}, :body => JSON.dump({:longUrl => URI.encode(url)})
      unless response.parsed_response["id"].nil?
        { :status => :success, :short_url => response.parsed_response["id"] }
      else
        fail
      end
    end
  end

  # URL Shortener for is.gd
  class IsGd < UrlShortener
    base_uri "http://is.gd/"
    format :json
    def self.shorten url
      response = get "/create.php", :query => {:format => "json", :url => URI.encode(url)}
      unless response.parsed_response["shorturl"].nil?
        { :status => :success, :short_url => response.parsed_response["shorturl"] }
      else
        fail
      end
    end
  end

  # URL Shortener for Jumbo Tweet
  class JumboTweet < UrlShortener
    base_uri "http://jmb.tw"
    format :plain
    def self.shorten url
      response = get "/api/create", :query => { :newurl => URI.encode(url)}
      if response.match("^http://jmb.tw/.+")
        { :status => :success, :short_url => response.parsed_response }
      else
        fail
      end
    end
  end

  # URL Shortener for metamark
  class MetaMark < UrlShortener
    base_uri "http://metamark.net"
    format :plain
    def self.shorten url
      response = get "/api/rest/simple", :query => { :long_url => URI.encode(url)}
      if response.match("^http://xrl.us/.+")
        { :status => :success, :short_url => response.parsed_response }
      else
        fail
      end
    end
  end

  # URL Shortener for mtny.mobi
  class MtNy < UrlShortener
    base_uri "http://mtny.mobi"
    format :json
    def self.shorten url
      response = get "/api", :query => {:type => "json", :source => "web", :url => URI.encode(url)}
      unless response.parsed_response["url"].nil?
        { :status => :success, :short_url => response.parsed_response["url"] }
      else
        fail
      end
    end
  end

  # URL Shortener for  qr.cx
  class QrCx < UrlShortener
    base_uri "http://qr.cx"
    format :plain

    def self.shorten url
      response = get "/api/?", :query => {:longurl => URI.encode(url)}
      if response.match("^http://qr.cx/.+")
        { :status => :success, :short_url => response.parsed_response }
      else
        fail
      end
    end

  end

  # URL Shortener for shortr.info
  class Shortr < UrlShortener
    base_uri "http://shortr.info"
    format :json
    def self.shorten url
      response = get "/make-shortr.php", :query => {:format => "json", :url => URI.encode(url)}
      unless response.parsed_response["shortr"]["result"]["created"].nil?
        { :status => :success, :short_url => response.parsed_response["shortr"]["result"]["created"] }
      else
        fail
      end
    end
  end
  
end
