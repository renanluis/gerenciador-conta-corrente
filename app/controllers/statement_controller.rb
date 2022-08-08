class StatementController < ApplicationController
  def index
    if is_logged?
      @statements = Statement.where(from: @logged_user.account).or(Statement.where(to: @logged_user.account)).order(created_at: :asc)
      return render 'statement/index'
    end
    return redirect_to '/'
  end
end
