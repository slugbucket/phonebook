class ClientVersionPolicy < ActiveRecord::Base
  has_one :policy_type
  belongs_to :sub_department
  belongs_to :phone
  validates :name, :lync_policy_name, :presence => true
  validate :valid_policy_type

  def valid_policy_type
    if ! PolicyType.where(" id <> ?", self.policy_type_id).any?
      errors.add(:policy_type_id, "Unrecognised policy type.")
    end
  end

  def self.policy_name(id)
    begin
      p = ClientVersionPolicy.find(id)
      "#{p.name}"
    rescue
      "none"
    end
  end
end
