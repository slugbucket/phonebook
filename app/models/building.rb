class Building < ActiveRecord::Base
  belongs_to :room

  def self.building_name(id)
    begin
      b = Building.find(id)
    rescue
      Rails.logger.error "Error locating building with id #{id}."
      raise ActiveRecord::RecordNotFound, "Cannot locate building with id #{id}."
    end
    "#{b.name}"
  end
end