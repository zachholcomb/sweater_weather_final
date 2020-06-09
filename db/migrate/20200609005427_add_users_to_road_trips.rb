class AddUsersToRoadTrips < ActiveRecord::Migration[5.2]
  def change
    add_reference :road_trips, :user, foreign_key: true
  end
end
