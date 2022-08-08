module SessionsHelper
    def login
        session[:user_id] = @account.id
    end
    def logged_user
        @logged_user ||= Account.find_by(id: session[:user_id])
    end
    def redirect_logged_user
        if logged_user.present?
            redirect_to '/'
        end
    end
    def check_login
        if !logged_user.present?
            redirect_to '/'
        end
    end
    def is_logged?
        !logged_user.nil?
    end
    def logout
        session.delete(:user_id)
        @logged_user = nil
    end
end
