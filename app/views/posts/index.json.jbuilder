json.publicaciones @posts do |post|
	json.id post.id
	json.body post.body
	json.user post.user
	json.created_at post.created_at
	json.updated_at post.updated_at
	json.url post_url(post, format: :json)
end
