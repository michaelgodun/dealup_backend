# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[8.1]
  def change
      create_table :users do |t|
        t.string :email, null: false, default: ""
        t.string :password_digest
        t.string :username
        t.string :refresh_token
        t.boolean :admin, default: false
        t.integer :status,default: 0, null: false

        t.timestamps null: false
      end

      add_index :users, :email, unique: true
  end
end
