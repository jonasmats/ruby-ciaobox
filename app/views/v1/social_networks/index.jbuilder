json.social_networks @social_networks do |social_network|
  json.id social_network.id
  json.name social_network.name
  json.link social_network.link
  json.icon_url social_network.icon.url
end
