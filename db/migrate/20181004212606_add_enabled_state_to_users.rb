class AddEnabledStateToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :enabled, :boolean, null: false, default: false
  end
end
