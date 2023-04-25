# frozen_string_literal: true

require_relative "gpt/version"
require 'uri'
require 'net/http'
require 'json'



module Gpt
  class Error < StandardError; end

  print "[USER] > "
    content = gets.chomp

    url = URI("https://openai80.p.rapidapi.com/chat/completions")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'application/json'
    request["X-RapidAPI-Key"] = 'a15743dab3msh010a3fe57c19bb3p15b291jsn71ca2090675c'
    request["X-RapidAPI-Host"] = 'openai80.p.rapidapi.com'
    request.body = "{
        \"model\": \"gpt-3.5-turbo\",
        \"messages\": [
            {
                \"role\": \"user\",
                \"content\": \"#{content}\"
            }
        ]
    }"

    response = http.request(request)
    parsed_json = JSON.parse(response.body)
    parsed_json["choices"].each do |choice|
      puts choice["message"]["content"]
    end


end
