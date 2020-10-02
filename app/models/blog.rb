class Blog < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  validates :content_or_picture, presence: true

  mount_uploader :picture, PictureUploader

  def content_or_picture
    content.presence or picture.presence
  end
end
