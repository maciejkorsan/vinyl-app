class Log < ApplicationRecord
  belongs_to :record


  after_create_commit :broadcast_log_created
  after_destroy_commit :broadcast_log_removed
  after_commit :broadcast_record_update, on: [ :create, :destroy, :update ]

  private

  def broadcast_log_created
    broadcast_prepend_to "logs"
  end

  def broadcast_log_removed
    broadcast_remove_to "logs"
  end

  def broadcast_record_update
    record = Record.find_by(id: record_id)

    broadcast_replace_to "records",
                         target: "record_#{record_id}",
                         partial: "records/record",
                         locals: { record: record } if record
  end
end
