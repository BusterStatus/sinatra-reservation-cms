require "sinatra"
get "/" do
  erb ./app/views/index
end