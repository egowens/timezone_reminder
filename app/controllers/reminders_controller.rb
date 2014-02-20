class RemindersController < ApplicationController
  before_action :signed_in_user,  only: [:create, :destroy]
  before_action :correct_user,    only:  :destroy

  def create
    @reminder = current_user.reminders.build(mod_params)
    if @reminder.save
      flash[:success] = "Reminder created!"
      redirect_to root_url
    else
      @reminder.time = ''
      @reminder_items = current_user.reminder_feed
      render 'static_pages/home'
    end
  end

  def destroy
    @reminder.destroy
    redirect_to root_url
  end

  private

    def reminder_params
      params.require(:reminder).permit(:content, :time)
    end

    def mod_params
      mod = reminder_params
      if mod[:time] != ''
        mod[:time] = Time.strptime(mod[:time], "%m/%d/%Y %H:%M %p")
      end
      mod
    end

    def correct_user
      @reminder = current_user.reminders.find_by(id: params[:id])
      redirect_to root_url if @reminder.nil?
    end
end
