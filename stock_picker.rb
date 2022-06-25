def stock_picker(array)
    best_buy = 0
    best_sell = 0
    buy = 0
    sell = 1
    profit = 0
    while buy < array.length-1
        if sell <= array.length-1
            if array[sell]-array[buy] < profit
               sell +=1
            elsif array[sell]-array[buy] > profit
               best_buy = buy
               best_sell = sell
               profit = array[sell]-array[buy]
               sell += 1
            end
        elsif sell = array.length-1
            buy +=1
            sell = buy +1
        end
    end

    print [best_buy,best_sell,profit]
end

stock_picker([17,3,6,9,15,8,6,1,10])