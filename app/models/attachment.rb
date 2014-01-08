class Attachment < ActiveRecord::Base
  belongs_to :ticket
  mount_uploader :attachment, AttachmentUploader
end
