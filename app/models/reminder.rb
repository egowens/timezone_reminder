class Reminder < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('time ASC') }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :time, presence: true

  searchable do
    text :content
  end
end
