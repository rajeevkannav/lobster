module RequestSpecHelper
  # Parse json response to ruby HASH
  #
  def json(response)
    JSON.parse(response.body)
  end
end