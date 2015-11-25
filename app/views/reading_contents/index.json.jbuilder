json.array!(@reading_contents) do |reading_content|
  json.extract! reading_content, :id
  json.url reading_content_url(reading_content, format: :json)
end
