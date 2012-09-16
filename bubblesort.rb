def bubble_sort(items)
	local_items = items
	swapped = true
	while swapped
		swapped = false
		for i in 1..local_items.length-1
			if local_items[i-1] > local_items[i] then
				local_items[i-1], local_items[i] = local_items[i], local_items[i-1]
				swapped = true
			end
		end
	end
	
	return local_items;
end

values = [200, -2, 9,4,10,12,104,3,5,10,3,2,25,6,182,21,33,23,19,13,38,26,12,3]

puts "length = #{values.length}"

sorted_values = bubble_sort(values)

puts sorted_values