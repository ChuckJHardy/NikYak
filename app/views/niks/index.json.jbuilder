json.array!(@niks) do |nik|
  json.extract! nik, :id, :title, :body, :limit, :user_id
  json.url nik_url(nik, format: :json)
end
