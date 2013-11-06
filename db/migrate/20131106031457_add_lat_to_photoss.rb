class AddLatToPhotoss < ActiveRecord::Migration
  def change
    add_column :photos, :lat, :decimal
  end
end
