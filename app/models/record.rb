class Record < ApplicationRecord
  has_one_attached :cover
  belongs_to :artist
  has_many :logs, dependent: :destroy

  after_create_commit do
    broadcast_prepend_to "records",
                        target: "records",
                        partial: "records/record",
                        locals: { record: self }
  end


  after_update_commit -> { broadcast_refresh_later_to("logs") }
  after_create_commit  -> { broadcast_refresh_later_to("logs") }
  after_destroy_commit -> { broadcast_refresh_later_to("logs") }

  validates :title, presence: true
end
