class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :value
      t.references :votable, polymorphic: true, index: true
      t.timestamps null: false
    end
    add_index :votes, :user_id
    belongs_to :user
  end
end
