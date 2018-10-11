class CreateTaggeds < ActiveRecord::Migration[5.2]
  def change
    create_table :taggeds do |t|
      t.references :article, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
  end
end
