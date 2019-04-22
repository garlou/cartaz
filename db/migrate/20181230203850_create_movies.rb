class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :year
      t.string :runtime
      t.string :runtime
      t.jsonb :genres, default: []
      t.jsonb :platforms, default: []
      t.timestamp :last_scrap
      t.timestamps
    end
  end
end
