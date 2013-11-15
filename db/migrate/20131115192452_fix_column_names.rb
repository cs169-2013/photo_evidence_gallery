class FixColumnNames < ActiveRecord::Migration
  def change
  	rename_column :photos, :incidentName, :incident_name
  	rename_column :photos, :operationalPeriod, :operational_period
  	rename_column :photos, :teamNumber, :team_number
  	rename_column :photos, :contentType, :content_type
  	rename_column :photos, :filename, :file_name
  	#remove_column :photos, :binaryData
  end
end