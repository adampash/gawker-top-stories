class AddUserIdToFrontPages < ActiveRecord::Migration
  def change
    add_column :front_pages, :user_id, :integer
  end
end
