class Blog < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy

  mount_uploader :picture, PictureUploader
end
