module Concerns
  module Scorable
    extend ActiveSupport::Concern

    def order(offset, per_page)
      <<-SQL
        ORDER BY scores.ratings DESC, scores.votes DESC
        OFFSET #{offset}
        LIMIT #{per_page}
      SQL
    end

    def sql
      <<-SQL
        SELECT scores.*,
        movies.title,
        movies.genres,
        movies.year,
        movies.platforms
        FROM (
            SELECT DISTINCT "scores".scorable_id,
                            sum(replace(scores.votes,',','')::NUMERIC) AS votes,
                            avg(cast(scores.rating AS DOUBLE precision)) AS ratings,
                            max(LANGUAGE) AS LANGUAGE,
                            max(country) AS country,
                            max(poster) AS poster

            FROM "scores"
            WHERE "scores"."rating" <> 'N/A' AND
                  "scores"."votes" <> 'N/A' AND
                  scores.scorable_type = 'Movie'

            GROUP BY scorable_type, scorable_id
        ) AS scores

        INNER JOIN movies ON movies.id = scores.scorable_id

        WHERE scores.votes > 2000
      SQL
    end
  end
end
