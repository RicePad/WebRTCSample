class Category < ActiveRecord::Base

  has_many :user_categories
  has_many :users, through: :user_categories

  validates :name, presence: true, length: {minimum: 3, maximum: 25}
  validates_uniqueness_of :name
end