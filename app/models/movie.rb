class Movie < ActiveRecord::Base

    def self.ratings_set
      ['G','PG','PG-13','R']
    end



end
