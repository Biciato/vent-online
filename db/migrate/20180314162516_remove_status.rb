class RemoveStatus < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :status, :boolean
  end
end
