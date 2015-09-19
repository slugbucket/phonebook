class Phone < ActiveRecord::Base
  has_one :sub_department
  has_one :archiving_policy
  has_one :client_version_policy
  has_one :conference_policy, through: :conferencing_policy_id
  has_one :dial_plan_policy
  has_one :external_access_policy
  has_one :location_policy
  has_one :mobility_policy
  has_one :persist_chat_policy
  has_one :pin_policy
  has_one :voice_policy
  #has_one :extension
  has_one :room

  validates :archiving_policy_id, :client_version_policy_id, :conferencing_policy_id, :dial_plan_policy_id, :external_access_policy_id, :location_policy_id, :mobility_policy_id, :persist_chat_policy_id, :pin_policy_id, :voice_policy_id, :presence => true

  validates :ext_number, allow_blank: true, format: {with: /\A\d+\Z/, message: "must only contain digits or be blank"}

  # Custom validator to ensure that the submitted extension number is within teh 
  # sub-department's extension ranges
  validate :is_valid_extension, :is_extension_in_subdept_range, :extension_already_allocated, on: :update

  def is_extension_in_subdept_range
    errors.add(:ext_number, "#{ext_number} must be within sub-department extension ranges") if ext_number != '' && Extension.sub_dept_extensions(sub_department_id).where(extension: ext_number).count == 0
  end
  def extension_already_allocated
    u = Phone.select(:uid).where(ext_number: ext_number).where.not(uid: uid).ext_number_not_null[0]
    if u then
      errors.add(:ext_number, "#{ext_number} already allocated to #{u.uid}")
    end
  end
  def is_valid_extension
    if ext_number != '' && ! Extension.ext_id(ext_number) then
      errors.add(:ext_number, "#{ext_number} is not a valid extension number")
    end
  end
  #def sub_department_id=(ids)
  #  self.sub_department_ids = ids
  #end
  #def dialling_right_id=(ids)
  #  self.dialling_right_ids = ids
  #end
  #def room_id=(ids)
  #  self.room_ids = ids
  #end
  def user_name()
    "#{firstname} #{surname}"
  end
  # Search methods
  def self.phones_by_subdept
    Phone.select("sub_departments.id, sub_departments.name AS subdept_name, phones.id, phones.uid, firstname, surname, ext_number").joins(:sub_departments)
  end
  def self.phones_in_subdept(sdept)
    Phone.select("phones.id, phones.uid, phones.firstname, phones.surname, phones.room_id, phones.extension_id, ext_number, phones.sub_department_id").where(:sub_department_id => sdept)
  end
  def self.find_by_extension(ext)
    Phone.joins(" INNER JOIN extensions ON phones.extension_id = extensions.id").where("extensions.extension = ?", ext)
  end
  def self.find_by_location(room)
    Phone.joins(" INNER JOIN rooms ON phones.room_id = rooms.id").where("rooms.public_name LIKE ?", "%"+room+"%")
  end
  # Create a hash array of teh policy attributes for the Phone object so that it can be
  # passed to the Phone.update method (even though it's deprecated) when updating a
  # Phone in another controller (sub_departments)
  def to_hash
    {"id"                        => "#{id}",
     "uid"                       => "#{uid}",
     "firstname"                 => firstname,
     "surname"                   => surname,
     "extension_id"              => "#{extension_id}",
     "room_id"                   => "#{room_id}",
     "archiving_policy_id"       => "#{archiving_policy_id}",
     "client_policy_id"          => "#{client_policy_id}",
     "client_version_policy_id"  => "#{client_version_policy_id}",
     "conferencing_policy_id"    => "#{conferencing_policy_id}",
     "dial_plan_policy_id"       => "#{dial_plan_policy_id}",
     "external_access_policy_id" => "#{external_access_policy_id}",
     "location_policy_id"        => "#{location_policy_id}",
     "mobility_policy_id"        => "#{mobility_policy_id}",
     "persist_chat_policy_id"    => "#{persist_chat_policy_id}",
     "pin_policy_id"             => "#{pin_policy_id}",
     "voice_policy_id"           => "#{voice_policy_id}"
    }
  end
  # Filter host names by their first letter - used for alphabetic pagination
  scope :by_letter, ->(initial) {where("surname LIKE \'%#{initial}%\'") }
  scope :extension_in_sub_dept_range, -> {Extension.sub_dept_extensions(sub_department_id).where ext_number: number}
  scope :ext_number_not_null, -> {where.not(ext_number: nil)}
  # Return all the Phone records in a given sub-department that have at least
  # one policy value matching the sub-departmental default and where a match
  # is found substitute in submitted value from a sub-department update
  # The params is the array of submitted sub_department values which should
  # include the policy values. If they're not present we will probably
  # have some breakage. 
  scope :policy_type_affectees, ->(sub_dept_id, params) {find_by_sql("
  SELECT p.id AS id,
    p.firstname AS firstname,
    p.surname AS surname,
    p.uid AS uid,
    p.extension_id AS extension_id,
    p.room_id AS room_id,
    CASE p.archiving_policy_id
      WHEN sd.archiving_policy_id THEN #{params[:archiving_policy_id]}
      ELSE p.archiving_policy_id
    END AS archiving_policy_id,
    CASE p.client_policy_id
      WHEN sd.client_policy_id THEN #{params[:client_policy_id]}
      ELSE p.client_policy_id
    END AS client_policy_id,
    CASE p.client_version_policy_id
      WHEN sd.client_version_policy_id THEN #{params[:client_version_policy_id]}
      ELSE p.client_version_policy_id
    END AS client_version_policy_id,
    CASE p.conferencing_policy_id
      WHEN sd.conferencing_policy_id THEN #{params[:conferencing_policy_id]}
      ELSE p.conferencing_policy_id
    END AS conferencing_policy_id,
    CASE p.dial_plan_policy_id
      WHEN sd.dial_plan_policy_id THEN #{params[:dial_plan_policy_id]}
      ELSE p.dial_plan_policy_id
    END AS dial_plan_policy_id,
    CASE p.external_access_policy_id
      WHEN sd.external_access_policy_id THEN #{params[:external_access_policy_id]}
      ELSE p.external_access_policy_id
    END AS external_access_policy_id,
    CASE p.location_policy_id
      WHEN sd.location_policy_id THEN #{params[:location_policy_id]}
      ELSE p.location_policy_id
    END AS location_policy_id,
    CASE p.mobility_policy_id
      WHEN sd.mobility_policy_id THEN #{params[:mobility_policy_id]}
      ELSE p.mobility_policy_id
    END AS mobility_policy_id,
    CASE p.persist_chat_policy_id
      WHEN sd.persist_chat_policy_id THEN #{params[:persist_chat_policy_id]}
      ELSE p.persist_chat_policy_id
    END AS persist_chat_policy_id,
    CASE p.pin_policy_id
      WHEN sd.pin_policy_id THEN #{params[:pin_policy_id]}
      ELSE p.pin_policy_id
    END AS pin_policy_id,
    CASE p.voice_policy_id
      WHEN sd.voice_policy_id THEN #{params[:voice_policy_id]}
      ELSE p.voice_policy_id
    END AS voice_policy_id
FROM
phones p INNER JOIN sub_departments sd
  ON p.sub_department_id = sd.id
 WHERE (p.dial_plan_policy_id = sd.dial_plan_policy_id
  OR p.voice_policy_id = sd.voice_policy_id
  OR p.external_access_policy_id = sd.external_access_policy_id
  OR p.archiving_policy_id = sd.archiving_policy_id
  OR p.client_version_policy_id = sd.client_version_policy_id
  OR p.pin_policy_id = sd.pin_policy_id
  OR p.location_policy_id = sd.location_policy_id
  OR p.mobility_policy_id = sd.mobility_policy_id
  OR p.persist_chat_policy_id = sd.persist_chat_policy_id
  OR p.conferencing_policy_id = sd.conferencing_policy_id
  OR p.client_policy_id = sd.client_policy_id)
  AND sd.id = #{sub_dept_id}")}
end