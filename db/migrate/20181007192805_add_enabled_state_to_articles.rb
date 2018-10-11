class AddEnabledStateToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :enabled, :boolean, null: false, default: false
  end
end
