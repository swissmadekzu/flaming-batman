class Ticket < ActiveRecord::Base
  include AASM
  
  belongs_to :author, class_name: User, inverse_of: :tickets
  belongs_to :tech, class_name: User, inverse_of: :work_tickets
  belongs_to :status
  belongs_to :emergency
  belongs_to :category

  has_many :messages
  has_many :attachments
  
  def full_name
    "[##{id}] #{title}"
  end
  
  # Acts as State Machine
  aasm do
    
    state :new, initial: true
    state :open
    state :pending
    state :solved
    
    event :open_ticket do
      transitions from: :new, to: :open
    end
    
    event :wait_for_validation do
      transitions from: :open, to: :pending
    end
    
    event :reopen do
      transitions from: :pending, to: :open
    end
    
    event :validate do
      transitions from: :pending, to: :solved
    end
    
  end
end
