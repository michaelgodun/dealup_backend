class CreateDeals < ActiveRecord::Migration[8.1]
  def change
    create_table :deals do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :description, null: false
      t.string :url
      t.decimal :price, precision: 10, scale: 2, null: false
      t.decimal :original_price, precision: 10, scale: 2
      t.datetime :start_date
      t.datetime :end_date
      t.integer :views, default: 0
      t.string :category, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
