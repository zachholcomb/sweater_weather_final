class AddAttributesToRoadTrip < ActiveRecord::Migration[5.2]
  def change
    add_column :road_trips, :travel_time, :string
    add_column :road_trips, :temp, :integer
    add_column :road_trips, :weather_summary, :string
  end
end
