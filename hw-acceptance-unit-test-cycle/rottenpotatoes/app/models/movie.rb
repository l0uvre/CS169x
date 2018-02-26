class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.find_by_same_director(id)
    movie = Movie.find(id)
    t_director = movie.director
    if not t_director.blank?
      movies = Movie.where(director: t_director)
    else
      movies = nil
    end
    return movies
  end
end
