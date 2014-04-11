class Category < ActiveRecord::Base
  belongs_to :department

  validates :name, :presence => true, :uniqueness => true

  def self.category_name(id)
    "#{Category.find(id).name}"
  end
end
