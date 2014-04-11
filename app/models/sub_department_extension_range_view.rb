class SubDepartmentExtensionRangeView < ActiveRecord::Base
  self.table_name = "sub_department_extension_range_view"

  def extension_range
    "#{first_extension} - #{last_extension}"
  end
  def extension_range_by_id(er_id)
    ExtensionRange.where(:id => er_id).pluck(:first_extension, :last_extension).map {|e| "#{e[0]} - #{e[1]}" }
  end
end
