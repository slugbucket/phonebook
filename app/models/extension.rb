class Extension < ActiveRecord::Base
  belongs_to :phone 

  validates :extension, :presence => true, :uniqueness => true

  def get_extension()
    "#{extension}"
  end
  def self.ext_number(id)
    e = Extension.find(id)
    "#{e.extension}"
  end
  # Scope to identify extensions in a given range
  scope :active_extensions, ->(first, last) { where("extension >= ? AND extension <= ?", first, last) }
  # Scope to identify the next available extension for the sub_department to exclude any aleady allocated extensions
  scope :sub_dept_next, ->(subdept) {select(:id, :extension).joins(", sub_department_extension_range_view").where("sub_department_id = ? AND (extension >= first_extension AND extension <= last_extension) AND id NOT IN (SELECT extension_id FROM phones WHERE extension_id IS NOT NULL)", subdept).limit(50)}
  # Scope to get my extension
  scope :my_extension_scope, ->(id) {Extension.joins(:phones).where("phone_id = ?", id).limit(1)}
end
