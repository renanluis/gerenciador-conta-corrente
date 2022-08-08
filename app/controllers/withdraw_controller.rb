class WithdrawController < ApplicationController
  def index
    if is_logged?
      return render 'withdraw/index'
    end
    return redirect_to '/'
  end

  def create
    if is_logged?
      if !params[:value].present?
        @error = 'Preencha o valor de saque.'
        return render 'withdraw/index'
      end
      @value = params[:value].to_f
      if @value <= 0
        @error = 'Informe um valor maior que 0.'
        return render 'withdraw/index'
      end
      if !@logged_user.vip && @value > @logged_user.balance
          @error = 'Você não pode sacar um valor maior que o seu saldo.'
          return render 'withdraw/index'
      end
      if add_to_balance(-@value, @logged_user)
        Statement.create(desc: "Saque", value: @value, from: @logged_user.account, to: 0)
        @success = 'Saque realizado com sucesso.'
        return render 'withdraw/index'
      end

    end
    return redirect_to '/'
    
  end
end
