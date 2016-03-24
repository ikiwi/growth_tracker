json.array! @stories do |story|
  json.id story.id
  json.title story.title
  json.text story.text
  json.published story.published
  json.archived story.archived
  json.featured story.featured
  json.user_id story.user_id
  json.hashtags story.tags.collect(&:hashtags)
end