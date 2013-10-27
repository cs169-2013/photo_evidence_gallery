class AddEditedToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :edited, :boolean
  end
end
