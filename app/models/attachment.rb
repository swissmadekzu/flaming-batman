class Attachment < ActiveRecord::Base
  belongs_to :ticket
  mount_uploader :attachment, AttachmentUploader
  has_many :log_entries
end
