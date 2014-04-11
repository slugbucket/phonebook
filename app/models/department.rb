class Department < ActiveRecord::Base

  belongs_to :sub_department
  has_one :category
  has_and_belongs_to_many :extension_ranges, :join_table => :departments_extension_ranges

  attr_reader :extension_range_tokens

  validates :name, :category_id, :presence => true
  validates :name, :uniqueness => true
 
  def extension_range_tokens=(ids)
    self.extension_range_ids = ids
  end
  def self.dept_name(id)
    "#{Department.find(id).name}"
  end
end
