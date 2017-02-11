json.extract! news, :id, :title, :snippet, :url, :created_at, :updated_at
json.url news_url(news, format: :json)