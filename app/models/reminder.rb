class Reminder < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('time ASC') }
  validates :content, presence: true, length: { maximum: 140 }
  validates :time, presence: true
  validates :user_id, presence: true
end
