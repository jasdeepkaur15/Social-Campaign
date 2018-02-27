class AddColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :oauth_token, :string
    add_column :users, :oauth_user_name, :string
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :oauth_expires_at, :string
    add_column :users, :linked_in_id, :string
    add_column :users, :oauth_secret, :string
    add_column :users, :subdomain, :string  	
    add_column :users, :provider, :string
    add_column :users, :uid, :string
  end
end
