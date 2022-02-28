class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      
      t.integer :genre_id
      t.integer :user_id
      t.string :image_id
      t.string :name
      t.text :introduction

      t.timestamps
    end
  end
end
