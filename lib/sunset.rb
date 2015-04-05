require 'net/http'
require 'time'
require 'date'
require 'json'

module Sunset
  SUNSET_URL = "http://api.sunrise-sunset.org/json?lat=41.6050&lng=-72.8792"
  def self.at
    url = URI.parse(SUNSET_URL)
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    response = JSON.parse(res.body)
    if response["status"] == "OK"
      raw_sunset = response["results"]["sunset"]
      sunset_utc = Time.strptime("#{Date.today} #{raw_sunset} UTC", "%Y-%m-%d %l:%M:%S %p %Z")
      sunset_utc.localtime
    end
  end
end
