class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @reminder = current_user.reminders.build
      @reminder_items = current_user.reminder_feed
      @search = @reminder_items.search do
        fulltext params[:search]
      end
      @reminder_items = @search.results
    end
  end

  def help
  end

  def about
  end
end
