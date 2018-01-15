class Post < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/

  belongs_to :user

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
