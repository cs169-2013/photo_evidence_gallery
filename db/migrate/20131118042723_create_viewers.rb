class CreateViewers < ActiveRecord::Migration
  def change
    create_table :viewers do |t|

      t.timestamps
    end
  end
end
