module BalanceHelper
    def get_balance(account)
        if !account.due.nil? && account.due > 0 && account.balance.negative?
            @timeDiff = Time.now.to_i - account.due
            @totalMinutes = (@timeDiff / 60).floor
            account.balance = (account.balance.abs * ((1 + 0.001) ** @totalMinutes)).floor(2)
            return -account.balance
        end
        return account.balance.floor(2)
    end
    def add_to_balance(value, account)
        @newBalance = (get_balance(account) + value).floor(2)
        account.balance = @newBalance
        account.due = 0
        if @newBalance < 0
          account.due = Time.now().to_i
        end
        return account.save
    end
end
