require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  all_characters = RestClient.get('http://www.swapi.co/api/people/')
  character_hash = JSON.parse(all_characters)
  movies_api = get_movies(character_hash,character)
      # iterate over the character hash to find the collection of `films` for the given
      #   `character`
      # collect those film API urls, make a web request to each URL to get the info
      #  for that film
      # return value of this method should be collection of info about each film.
      #  i.e. an array of hashes in which each hash reps a given film
      # this collection will be the argument given to `parse_character_movies`
      #  and that method will do some nice presentation stuff: puts out a list
      #  of movies by title. play around with puts out other info about a given film.
end

def get_movies(character_hash, character)
  character_array=character_hash["results"]
  character_array.each do |hash|
    return hash["films"] if hash["name"].downcase==character
  end
end


def parse_character_movies(films_array)
  # some iteration magic and puts out the movies in a nice list
  movies_array = []
  films_array.each do |movie_url|
    name = RestClient.get(movie_url)
    movie_hash = JSON.parse(name)
    title = movie_hash["title"]
    movies_array << title
  end

  movies_array
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash).each {|movie| puts movie}
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
