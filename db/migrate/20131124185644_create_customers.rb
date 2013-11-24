class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :mobilenumber
      t.string :authtoken
      t.string :locationtarget
      t.string :pricepoint

      t.timestamps
    end
  end
end
