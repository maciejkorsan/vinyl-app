class Log < ApplicationRecord
  belongs_to :record



  after_update_commit -> { broadcast_refresh_later_to("logs") }
  after_create_commit  -> { broadcast_refresh_later_to("logs") }
  after_destroy_commit -> { broadcast_refresh_to("logs") }
end
