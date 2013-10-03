class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :caption
      t.string :tags
      t.string :incidentName
      t.string :operationalPeriod
      t.string :teamNumber
      t.string :contentType
      t.string :filename
      t.binary :binaryData

      t.timestamps
    end
  end
end
