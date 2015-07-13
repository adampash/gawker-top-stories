class AddAltDomainToUser < ActiveRecord::Migration
  def change
    add_column :users, :alt_domain, :string
  end
end
