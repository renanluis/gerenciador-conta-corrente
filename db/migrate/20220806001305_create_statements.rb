class CreateStatements < ActiveRecord::Migration[7.0]
  def change
    create_table :statements do |t|
      t.text :desc
      t.float :value
      t.integer :from
      t.integer :to

      t.timestamps
    end
  end
end
