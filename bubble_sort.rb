def bubble_sort(array)
    array.length.times do
        array.each_with_index do |value,idx|
            if array[idx+1] != nil
                if array[idx] > array[idx+1]
                    temp = array[idx]
                    array[idx] = array[idx+1]
                    array [idx+1] = temp
                end
            end
        end
    end
    print array
end

bubble_sort([4,3,78,2,0,2])