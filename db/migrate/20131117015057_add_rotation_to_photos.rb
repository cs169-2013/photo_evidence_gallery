class AddRotationToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :rotation, :int
  end
end
