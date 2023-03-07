class CreateAims < ActiveRecord::Migration[7.0]
  def change
    create_table :aims do |t|
      t.string :title
      t.text :reason
      t.text :advantage
      t.string :genre
      t.integer :difficulty

      t.timestamps
    end
  end
end
