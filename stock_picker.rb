def stock_picker(array)
  hash = Hash.new(0)
  array.each_with_index do |buy_element, buy_index|
    array.values_at(buy_index+1..-1).each_with_index do |sell_element, sell_index|
      if sell_element - buy_element > hash[:diff]
        hash[:diff] = sell_element - buy_element
        hash[:indexes] = [buy_index, sell_index + buy_index + 1]
      end
    end
  end
  p hash[:indexes]
end


stock_picker([17,3,6,9,15,8,6,1,10])