class CreateRoadTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :road_trips do |t|
      t.string :origin
      t.string :destination

      t.timestamps
    end
  end
end
