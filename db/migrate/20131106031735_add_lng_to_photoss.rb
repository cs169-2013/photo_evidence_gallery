class AddLngToPhotoss < ActiveRecord::Migration
  def change
    add_column :photos, :lng, :decimal
  end
end
