class AddLastAvaliationToMovies < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :last_avaliation, :datetime, nullable: false, default: Time.zone.now
  end
end
