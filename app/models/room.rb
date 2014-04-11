class Room < ActiveRecord::Base
  belongs_to :phone

  validates :name, :public_name, :room_status_id, :building_id, :building_floor_id, :presence => true

  def self.room_name(id)
    r = Room.find(id)
    "#{r.public_name}"
  end
end
