class FixColumnNames2 < ActiveRecord::Migration
  def change
  	rename_column :photos, :file_name, :time_taken
  	rename_column :photos, :content_type, :taken_by
  end
end
