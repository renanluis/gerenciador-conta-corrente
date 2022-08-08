class BalanceController < ApplicationController
  def index
    if is_logged?
      @logged_user.balance = get_balance(@logged_user)
      return render 'balance/index'
    end
    return redirect_to '/'
  end
end
