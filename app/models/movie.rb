class Movie < ActiveRecord::Base
  # All possible movie ratings
  def self.all_ratings
    ['G','PG','PG-13','R']
  end
end
