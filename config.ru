require 'json'

class App
  def initialize
    @comments = [
      { "author" => "Pete Hunt",    "text" => "This is one comment" },
      { "author" => "Jordan Walke", "text" => "This is *another* comment" }
    ]
  end

  def call(env)
    request = Rack::Request.new(env)

    case request.path
    when "/comments.json"
      if request.request_method == "POST"
        @comments << { "author" => request["author"], "text" => request["text"] }
      end

      [ 200, { "Content-Type" => "application/json" }, [ @comments.to_json ] ]
    when "/"
      [ 200, { "Content-Type" => "text/html" }, File.open("template.html") ]
    else
      [ 404, {}, ["not found"] ]
    end
  end
end

run App.new
