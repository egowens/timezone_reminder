class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @reminder = current_user.reminders.build
      @reminder_items = current_user.reminder_feed
    end
  end

  def help
  end

  def about
  end
end
