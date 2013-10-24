class AddIndexToUsersEmail < ActiveRecord::Migration
  def change
  	add_index :users, :Email, unique:true
  end
end
