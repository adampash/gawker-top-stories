class AddTitleToFrontPage < ActiveRecord::Migration
  def change
    add_column :front_pages, :title, :string
  end
end
