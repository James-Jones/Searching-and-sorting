def insertion_sort(items)
	local_items = items
	
	for i in 1..local_items.length-1
		#pick an item
		value = local_items[i]
		hole = i
		
		#shift values down the array / move backwards until sorted
		while hole > 0 and local_items[hole-1] > value #while value is out of order
			local_items[hole] = local_items[hole-1] #move down
			hole = hole - 1
		end
		
		#fill the hole
		local_items[hole] = value
	end
	
	return local_items;
end

values = [200, -2, 9,4,10,12,104,3,5,10,3,2,25,6,182,21,33,23,19,13,38,26,12,3]

puts "length = #{values.length}"

sorted_values = insertion_sort(values)

puts sorted_values