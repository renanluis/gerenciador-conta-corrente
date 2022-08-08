class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.integer :account
      t.boolean :vip
      t.float :balance
      t.integer :due

      t.timestamps
    end
  end
end
