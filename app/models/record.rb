class Record < ApplicationRecord
  has_one_attached :cover
  belongs_to :artist
  has_many :logs, dependent: :destroy
end
