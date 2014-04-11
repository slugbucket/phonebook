class RoomStatus < ActiveRecord::Base
  belongs_to :room

  def self.room_status_name(id)
    rs = RoomStatus.find(id)
    "#{rs.name}"
  end
  # Experimental
  scope :public, -> { where(:name => "Public") }
end
