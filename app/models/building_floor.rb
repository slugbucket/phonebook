class BuildingFloor < ActiveRecord::Base
  belongs_to :room

  def self.building_floor_name(id)
    begin
      bf = BuildingFloor.find(id)
    rescue
      Rails.logger.error "Error locating building floor with id #{id}."
      raise ActiveRecord::RecordNotFound, "Cannot locate building floor with id #{id}."
    end
    "#{bf.name}"
  end
end
