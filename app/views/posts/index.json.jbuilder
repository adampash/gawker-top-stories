json.title @front_page.title
json.stories do
  json.array! @posts do |post|
    json.partial! 'posts/post', post: post
  end
end
