class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.references :scorable, polymorphic: true, index: true
      t.string :title
      t.string :year
      t.string :api
      t.string :source
      t.string :rating
      t.string :votes
      t.string :released
      t.string :director
      t.string :writer
      t.string :language
      t.string :country
      t.string :poster
      t.string :sourceid
      t.float  :similarity

      t.timestamps
    end
  end
end
