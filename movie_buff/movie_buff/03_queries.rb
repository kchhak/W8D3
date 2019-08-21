def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movie
    .select(:title, :id)
    .joins(:actors)
    .where(actors: { name: those_actors })
    .group('movies.id')
    .having('COUNT(actors.id) >= ?', those_actors.length)
end

def golden_age
  # Find the decade with the highest average movie score.
  Movie
    .select('((yr / 10) * 10) AS decade, AVG(movies.score)')
    .group('decade')
    .order('AVG(movies.score) DESC')
    .limit(1)
    .first
    .decade

end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery
  m = Movie
    .select(:id)
    .joins(:actors)
    .where('name = ?', name)
    .pluck(:id)

  Actor
    .select(:name)
    .distinct
    .joins(:castings)
    .where(castings: {movie_id: m}) 
    .where.not('name = ?', name)
    .pluck(:name)   

end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor
    .select('actors.id')
    .left_outer_joins(:castings)
    .where('movie_id IS NULL')
    .count
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"
  new_string = '%' + whazzername.split('').join('%') + '%'
  
  Movie
    .joins(:actors)
    .where('name ilike ?', new_string)
end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.

  Actor
    .select('actors.id, actors.name, (MAX(movies.yr) - MIN(movies.yr)) AS career')
    .joins(:movies)
    .group('actors.id')
    .order('career DESC', 'name ASC')
    .limit(3)
end
