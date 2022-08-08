module BalanceHelper
    def get_balance(account)
        if !account.due.nil? && account.due > 0
            @timeDiff = Time.now.to_i - account.due
            @totalMinutes = (@timeDiff / 60).floor
            return account.balance * ((1 + 0.001) ** @totalMinutes)
        end
        return account.balance
    end
end
