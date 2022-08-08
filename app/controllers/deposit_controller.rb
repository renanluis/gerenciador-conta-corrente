class DepositController < ApplicationController
  def index
    if is_logged?
      return render 'deposit/index'
    end
    return redirect_to '/'
  end
  def create
    if is_logged?
      if !params[:value].present?
        @error = 'Preencha o valor que deseja depositar.'
        return render 'deposit/index'
      end
      @value = params[:value].to_f
      if @value <= 0
        @error = 'Informe um valor maior que 0.'
        return render 'deposit/index'
      end
      @newBalance = get_balance(@logged_user) + @value
      @logged_user.balance = @newBalance
      @logged_user.due = 0
      if @newBalance < 0
        @logged_user.due = Time.now().to_i
      end
      @deposit = @logged_user.save
      if !@deposit
        @error = 'Ocorreu um erro ao tentar depositar na sua conta. Tente novamente.'
        return render 'deposit/index'
      end
      Statement.create(desc: "Depósito", value: @value, from: 0, to: @logged_user.account)
      @success = 'Depósito realizado com sucesso.'
      return render 'deposit/index'
    end
    return redirect_to '/'
  end
end
