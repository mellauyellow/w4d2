class Cat < ActiveRecord::Base
  COLORS = %w(black white grey brown orange)
  validates :name, presence: true, uniqueness: true
  validates :birth_date, presence: true
  validates :color, inclusion: { in: COLORS,
    message: "%{value} is not a valid color"}, presence: true
  validates :sex, inclusion: { in: %w(M F),
    message: "%{value} is not a valid sex"}, presence: true

  has_many :rentals,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :CatRentalRequest,
    dependent: :destroy

  def age
    Date.today.year - self.birth_date.year
  end
end
