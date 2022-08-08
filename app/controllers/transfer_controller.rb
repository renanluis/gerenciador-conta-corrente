class TransferController < ApplicationController
  def index
    if is_logged?
      return render 'transfer/index'
    end
    return redirect_to '/'
  end
  def create
    if is_logged?
      if !params[:value].present? || !params[:to].present?
        @error = 'Preencha todos os campos.'
        return render 'transfer/index'
      end
      @to = params[:to].to_i
      @value = params[:value].to_f
      if @to == @logged_user.account
        @error = 'Você não pode transferir para você mesmo.'
        return render 'transfer/index'
      end
      if @value <= 0
        @error = 'Informe um valor maior que 0.'
        return render 'transfer/index'
      end
      if !@logged_user.vip && @value > 1000
        @error = 'Você não pode transferir um valor acima de R$1000,00.'
        return render 'transfer/index'
      end
      if @value > @logged_user.balance
        @error = 'Você não pode transferir um valor maior que o seu saldo.'
        return render 'transfer/index'
      end
      @getDest = Account.find_by(account: @to)
      if @getDest.nil?
        @error = 'A conta informada não existe.'
        return render 'transfer/index'
      end
      @newBalance = @logged_user.balance - @value
      @transferTax = 8
      if @logged_user.vip
        @transferTax = 0.008 * @value
      end
      @newBalance -= @transferTax
      @senderUpdate = @logged_user.update(balance: @newBalance)
      @destBalance = get_balance(@getDest)
      @getDest.balance = @destBalance + @value
      @getDest.due = 0
      if @getDest.balance < 0
        @getDest.due = Time.now.to_i
      end
      @destUpdate = @getDest.save
      if !@senderUpdate || !@destUpdate
        @error = 'Houve algum erro ao transferir para essa conta. Tente novamente.'
        return render 'transfer/index'
      end
      Statement.create(desc: "Transferência", value: @value, from: @logged_user.account, to: @getDest.account)
      Statement.create(desc: "Taxa de transferência", value: @transferTax, from: @logged_user.account, to: 0)
      @success = 'Transferência realizada com sucesso para a conta: '+@getDest.account.to_s
      return render 'transfer/index'
    end
    return redirect_to '/'
  end
end
