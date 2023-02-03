def bubble_sort(array)
  n = array.length  
  while n > 1 do
    newn = 0
    for i in 1..n-1 do
      if array[i-1] > array[i]
        array[i-1], array[i] = array[i], array[i-1]
        newn = i
      end
    end
    n = newn
  end
  p array
end


bubble_sort([4,3,78,2,0,2])