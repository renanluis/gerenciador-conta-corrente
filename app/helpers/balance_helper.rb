module BalanceHelper
    def get_balance(account)
        if !account.due.nil? && account.due > 0
            @timeDiff = Time.now.to_i - account.due
            @totalMinutes = (@timeDiff / 60).floor
            return account.balance * ((1 + 0.001) ** @totalMinutes)
        end
        return account.balance
    end
    def add_to_balance(value, account)
        @newBalance = get_balance(account) + value
        account.balance = @newBalance
        account.due = 0
        if @newBalance < 0
          account.due = Time.now().to_i
        end
        return account.save
    end
end
