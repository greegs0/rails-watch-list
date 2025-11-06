require "json"
require "open-uri"

puts "Cleaning database..."
Movie.destroy_all

puts "Fetching movies from TMDB..."
url = "https://tmdb.lewagon.com/movie/top_rated"
serialized = URI.open(url).read
data = JSON.parse(serialized)

data["results"].each do |movie|
  Movie.create!(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: "https://image.tmdb.org/t/p/original#{movie["poster_path"]}",
    rating: movie["vote_average"]
  )
end

puts "✅ #{Movie.count} movies created!"
