class AddEnabledStateToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :enabled, :boolean, null: false, default: true
  end
end
