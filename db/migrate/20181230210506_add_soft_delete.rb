class AddSoftDelete < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :deleted_at, :timestamp
    add_column :genres, :deleted_at, :timestamp
  end
end
