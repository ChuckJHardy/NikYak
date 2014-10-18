json.array!(@yaks) do |yak|
  json.extract! yak, :id, :body, :nik_id, :user_id
  json.url yak_url(yak, format: :json)
end
