class DiallingRight < ActiveRecord::Base
  belongs_to :department
  belongs_to :phone

  def self.dialling_right_name(id)
    "#{DiallingRight.find(id).name}"
  end
end
