class PagesController < ApplicationController
  before_action :authenticate_user!, except: :welcome
  def welcome
    redirect_to dashboard_path if user_signed_in?
  end

  def front
    render nothing: true
  end

end
