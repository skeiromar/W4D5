class ChangeUserTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :password, :string
    add_column :users, :password_digest, :string, null: false
    add_column :users, :session_token, :string, null: false, unique: true

  end
end
