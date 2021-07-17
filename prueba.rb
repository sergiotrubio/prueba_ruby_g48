require "uri"
require "net/http"
require "json"

def request(address)
    url = URI(address)

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url)

    response = https.request(request)
    data = JSON.parse(response.read_body)
    data
end