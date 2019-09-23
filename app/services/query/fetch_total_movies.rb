# frozen_string_literal: true

module Query
  class FetchTotalMovies
    class << self
      include Concerns::Scorable

      def call(args={})
        ActiveRecord::Base.connection.execute(
          <<-SQL
            SELECT COUNT(*) FROM (#{sql}) as count
          SQL
        ).first['count']
      end
    end
  end
end
