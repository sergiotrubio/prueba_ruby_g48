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

def build_web_page
    hash_rover = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=xeWWb56qSwafBBq86t2RuCMg63i3hfCrSt8F3VQo")
    m = hash_rover["photos"].count
    lista = ""
    m.times do |f|
        photo = hash_rover["photos"][f]["img_src"]
        lista += "\t\t<li><img width='250' height='300' src=\"#{photo}\"></li>\n"
    end
    puts m
result = "<!DOCTYPE html>\n<html>\n<head>\n</head>\n<body>\n\t<ul>\n#{lista}\t</ul>\n</body>\n</html>"
end

pagina = build_web_page

File.write('index.html',pagina)