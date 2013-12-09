class CreateLocationTargets < ActiveRecord::Migration
  def change
    create_table :location_targets do |t|
      t.float :latitude
      t.float :longitude
      t.string :address
      t.string :description
      t.string :title

      t.timestamps
    end
  end
end
