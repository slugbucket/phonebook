class SubDepartment < ActiveRecord::Base
  belongs_to :phone
  has_one :department
  has_one :conference_policy, through: :conferencing_policy_id

  validates :name, :department_id, :sub_department_code, :presence => true
  validate :preferred_uniq_if_notnull
  
  def extension_range_by_id(sd_id)
    pref = self.preferred_extension_range_id
    ExtensionRange.where(:id => pref).pluck(:first_extension, :last_extension).map {|e| "#{e[0]} - #{e[1]}" }
  end
  # Custom validators
  def preferred_uniq_if_notnull
    if SubDepartment.where(" id <> ? AND preferred_extension_range_id = ?", self.id, self.preferred_extension_range_id).any?
      errors.add(:preferred_extension_range_id, "Cannot select preferred extension range already allocated.")
    end
  end
  # TODO - Validator to ensure that a preferred extension_range is a valid range

  def dept_subdept_name()
    "#{Department.find(self.department_id).name}::#{name}"
  end
  def self.subdept_name(id)
    s = SubDepartment.find(id)
    "#{s.name}"
  end
end
