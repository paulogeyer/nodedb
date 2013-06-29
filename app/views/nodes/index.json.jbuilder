json.array!(@nodes) do |node|
  json.extract! node, :lat, :lng, :user_id
  json.url node_url(node, format: :json)
end