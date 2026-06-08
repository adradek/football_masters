class WelcomeController < ApplicationController
  def index
    @groups = Group.order(:order).includes(:nations)
  end
end
