class CreatePostsubs < ActiveRecord::Migration
  def change
    create_table :postsubs do |t|
      t.integer :sub_id, null: false
      t.integer :post_id, null: false
      t.timestamps null: false
    end
    add_index :postsubs, :sub_id
    add_index :postsubs, :post_id
  end
end
