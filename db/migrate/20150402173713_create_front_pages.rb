class CreateFrontPages < ActiveRecord::Migration
  def change
    create_table :front_pages do |t|
      t.string :first
      t.string :second
      t.string :third
      t.string :site

      t.timestamps null: false
    end
  end
end
