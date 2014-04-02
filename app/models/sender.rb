class Sender < ActiveRecord::Base
  def self.next_for_delivery
    Reminder.all(:conditions => ["time <= ?", Time.now.utc], :order => "created_at")
  end

  def self.deliver
    @reminder = Reminder.all(:conditions => ["time <= ?", Time.now.utc], :order => "created_at")
    @reminder.each do |rem|
      user = User.find_by(id: rem.user_id)
      reminder = rem.content
      UserMailer.reminder_email(user, reminder).deliver
      rem.destroy
    end
  end
end
