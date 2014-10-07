class Extension < ActiveRecord::Base
  belongs_to :phone 

  validates :extension, :presence => true, :uniqueness => true

  def get_extension()
    "#{extension}"
  end
  # Method to return the id of a given extension number
  def self.ext_id(num)
    begin
      e = Extension.find_by_extension(num).id
      "#{e}"
    rescue
      nil
    end
  end
  def self.ext_number(id)
    begin
      e = Extension.find(id)
      "#{e.extension}"
    rescue
      "none"
    end
  end
  # Scope to identify extensions in a given range
  scope :active_extensions, ->(first, last) { where("extension >= ? AND extension <= ?", first, last) }
  # Scope to identify the next available extension for the sub_department to exclude any aleady allocated extensions
  scope :sub_dept_next, ->(subdept) {select(:id, :extension).joins(", sub_department_extension_range_view").where("sub_department_id = ? AND (extension >= first_extension AND extension <= last_extension) AND extensions.id NOT IN (SELECT extension_id FROM phones WHERE extension_id IS NOT NULL)", subdept).order(:extension)}
  # Get the valid extensions
  scope :sub_dept_extensions, ->(subdept) {select(:extension).joins(", sub_department_extension_range_view sderv").where("sderv.sub_department_id = ? AND (extension >= first_extension AND extension <= last_extension)", subdept).order(:extension)}
  # Additional scope to extract only unused extensions
  # Doesn't work because where is for an equality relation: id = NOT IN ...
  scope :extension_not_taken, -> {where.not(id: "(SELECT extension_id FROM phones WHERE extension_id IS NOT NULL)")}
end
