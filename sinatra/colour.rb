require 'sinatra'
require 'json'
require 'rest_client'

post '/word/?' do
  jdata = params[:data]
  word = JSON.parse(jdata)
  randomizeAndSend(word["word"],word["color_random"],"http://localhost:4568")  
end

def randomizeAndSend(word, color_random,stream_app_adress)
  if color_random
  #send with randomized colors
  tmp = Random.rand(1..3)
  case tmp
    #color red
    when 1
      color = "red"
    when 2
      color = "green"
    else
      color = "black"  
  end
  else
    color = "black"
  end
  
  response = RestClient.post stream_app_adress + '/stream', {:data=> {word: word, color: color}.to_json},{:content_type =>:json,:accept=> :json}

end
