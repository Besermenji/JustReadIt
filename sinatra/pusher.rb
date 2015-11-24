require 'pusher'
require 'sinatra'
require 'json'

set :port, 4568

post '/stream/?' do
  jdata = params[:data]
  stream = JSON.parse(jdata)
  Pusher.url = "https://eb7ba3e6d950f8d86a1f:47abbf1bb80cb375ebd1@api.pusherapp.com/apps/156547"
  Pusher.trigger('text_streamer', 'my_event', {
  message: stream["word"],
  color: stream["color"]
})



end
