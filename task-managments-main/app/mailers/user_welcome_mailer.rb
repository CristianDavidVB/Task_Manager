class UserWelcomeMailer < ApplicationMailer
  def welcome
    @user = params[:user]
    mail(to: @user.email, subject: "Tasks Managments")
  end
end
