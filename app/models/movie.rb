class Movie < ActiveRecord::Base
  def self.with_ratings(ratings_list)
    # if ratings_list is an array such as ['G', 'PG', 'R'], retrieve all
    #  movies with those ratings
    # if ratings_list is nil, retrieve ALL movies
    if @ratings_list.nil? 
      Movie.all
    else
      Movie.where(rating: [ratings_list])
    end
  end
  
  def self.all_ratings()
    #make a list of the ratings
    ['G', 'PG', 'PG-13', 'R', 'NC-17']
  end 
end