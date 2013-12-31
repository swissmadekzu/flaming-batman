class Ticket < ActiveRecord::Base
  belongs_to :author, class_name: User, inverse_of: :tickets
  belongs_to :techie, class_name: User, inverse_of: :work_tickets
  belongs_to :status
  belongs_to :emergency
  belongs_to :category

  has_many :messages
  has_many :attachments
end
