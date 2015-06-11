task :purge do
  api_key = ENV["FASTLY_KEY"]
  site_key = ENV["FASTLY_SITE_KEY"]
  `curl -X POST -H 'Fastly-Key: #{api_key}' https://api.fastly.com/service/#{site_key}/purge_all`
  puts 'Cache purged'
end
