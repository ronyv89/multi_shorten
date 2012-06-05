require 'httparty'
require 'open-uri'
module MultiShorten

  class UrlShortener
    include HTTParty

    def initialize
    end

    def shorten url
    end

    def fail
      { :status => :fail }
    end

  end

  class B54 < UrlShortener

    base_uri "http://b54.in/api"
    format :json

    def shorten url
      response = B54.get "/", :query => {:action => "shorturl", :url => URI.encode(url), :format => "json"} rescue return fail
      if response["shorturl"]
        {:status => :success, :short_url => URI.unescape(response["shorturl"])}
      else
        fail
      end
    end

  end

  class Linkee < UrlShortener
    base_uri "http://api.linkee.com/1.0/shorten"
    format :json
    def shorten url
      response = Linkee.get "/", :query => {:input => URI.encode(url)}
      begin
        if response["status"]["code"] == 200
          {:status => :success, :short_url => response["result"]}
        else
          {:status => :fail}
        end
      rescue
        return fail
      end

    end

  end

end
