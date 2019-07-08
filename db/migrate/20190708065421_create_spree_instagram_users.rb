class CreateSpreeInstagramUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_instagram_users do |t|
      t.string :username, null: false
      t.string :name
      t.timestamps
    end
  end
end
