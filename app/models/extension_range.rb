class ExtensionRange < ActiveRecord::Base
  has_and_belongs_to_many :departments, :join_table => :departments_extension_ranges

  validates :first_extension, :last_extension, :presence => true, :uniqueness => true
  # validator to ensure that last number is greater than the first
  validate :last_greater_than_first 

  attr_reader :department_tokens
 
  def extension_range
    "#{first_extension} - #{last_extension}"
  end
  def department_tokens=(ids)
    self.department_ids = ids
  end
  # custom validators
  def last_greater_than_first
    if last_extension < first_extension
      errors.add(:last_extension, "must be greater than the first")
    end
  end
  # Scopes
  # Scope to determine the preferred first and last extension for a sub-dept when specified
  scope :preferred_sub_dept, ->(sub_dept) {select(:first_extension, :last_extension).joins(" LEFT JOIN sub_departments ON preferred_extension_range_id = extension_ranges.id").where("preferred_extension_range_id IS NOT NULL AND sub_departments.id = ?", sub_dept)}
  scope :department_range, ->(dept) {select("extension_ranges.id", :first_extension, :last_extension).joins(:departments).where("departments.id" => dept)}
end
