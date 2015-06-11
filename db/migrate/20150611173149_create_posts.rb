class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :headline
      t.json :image
      t.string :deck
      t.string :permalink
      t.json :tags
      t.integer :kinja_id

      t.timestamps null: false
    end
  end
end
