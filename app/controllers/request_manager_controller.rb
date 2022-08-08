class RequestManagerController < ApplicationController
  def index
    if is_logged? && @logged_user.vip
      return render 'request_manager/index'
    end
    return redirect_to '/'
  end
  def create
    if is_logged? && @logged_user.vip && params[:commit].present?
      @logged_user.balance = get_balance(@logged_user)
      if @logged_user.balance < 50
        @error = 'Saldo insuficiente para solicitar visita do gerente.'
        return render 'request_manager/index'
      end
      @logged_user.balance -= 50
      if !@logged_user.save
        @error = 'Ocorreu um erro ao solicitar visita do gerente. Tente novamente.'
        return render 'request_manager/index' 
      end
      Statement.create(desc: "Solicitação de visita do gerente", value: 50, from: @logged_user.account, to: 0)
      @success = 'Visita do gerente solicitada com sucesso.'
      return render 'request_manager/index'
    end
    return redirect_to '/'
  end
end
