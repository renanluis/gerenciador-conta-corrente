class HomeController < ApplicationController
  def index
    if !is_logged?
        return render 'home/login'
    end
  end
end
