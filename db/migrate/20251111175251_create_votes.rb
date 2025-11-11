class CreateVotes < ActiveRecord::Migration[8.1]
  def change
    create_table :votes do |t|
      t.references :user, null: false, foreign_key: true
      t.references :deal, null: false, foreign_key: true
      t.integer :value

      t.timestamps
    end
    add_index :votes, [:user_id, :deal_id], unique: true
  end
end
