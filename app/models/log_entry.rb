class LogEntry < ActiveRecord::Base
  belongs_to :user
  belongs_to :ticket
  belongs_to :attachment
  belongs_to :message
end
