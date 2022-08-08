class SessionsController < ApplicationController
  before_action :redirect_logged_user, except: [:destroy]
  def create
    if !params[:account].present? || !params[:password].present?
      @error = "Preencha todos os campos."
      return render 'home/login'
    end
    @account = Account.find_by(account: params[:account])
    if @account && @account.authenticate(params[:password])
        login
        return redirect_to '/'
    else
      @error = "Usuário e/ou senha incorretos."
      return render 'home/login'
    end
  end
  def destroy
    logout
    return redirect_to root_url
  end
end
