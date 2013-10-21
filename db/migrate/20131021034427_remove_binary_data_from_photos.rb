class RemoveBinaryDataFromPhotos < ActiveRecord::Migration
  def change
    remove_column :photos, :binaryData, :binary
  end
end
