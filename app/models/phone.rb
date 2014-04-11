class Phone < ActiveRecord::Base
  has_one :sub_department
  has_one :dialling_right
  has_one :extension
  has_one :room

  validates :dialling_right_id, :presence => true

  def user_name()
    "#{firstname} #{surname}"
  end
  # Search methods
  def self.phones_by_subdept
    Phone.select("sub_departments.id, sub_departments.name AS subdept_name, phones.id, phones.uid, firstname, surname").joins(:sub_departments)
  end
  def self.phones_in_subdept(sdept)
    Phone.select("phones.id, phones.uid, phones.firstname, phones.surname, phones.room_id, phones.extension_id, phones.sub_department_id").where(:sub_department_id => sdept)
  end
  def self.find_by_extension(ext)
    Phone.joins(" INNER JOIN extensions ON phones.extension_id = extensions.id").where("extensions.extension = ?", ext)
  end
  def self.find_by_location(room)
    Phone.joins(" INNER JOIN rooms ON phones.room_id = rooms.id").where("rooms.public_name LIKE ?", "%"+room+"%")
  end
  # Filter host names by their first letter - used for alphabetic pagination
  scope :by_letter, ->(initial) {where("surname LIKE \'%#{initial}%\'") }
end
