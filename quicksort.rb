def basicquicksort(items)
	if items.length <= 1
		return items
	end

	pivotIndex = items.length/2
	pivotItem = items[pivotIndex]
	
	items.delete_at(pivotIndex)
	
	left = []
	right = []
	
	for i in items
		if i < pivotItem
			left.push i
		else
			right.push i
		end
	end
	
	middle = [pivotItem]
	
	return basicquicksort(left) + middle + basicquicksort(right)
end

# Move all elements less than items[pivot] before the pivot, and the equal or greater elements after it.
# Then return the final position of the pivot to use in the quicksort.
def partition(items, left, right, pivot)
	pivotItem = items[pivot];
	items[pivot],items[right] = items[right],items[pivot] # Move the pivot to the end.

	partitionIndex = left;
	
	# Iterate from left to right-1 (-1 since right is the pivot)
	left.upto(right-1) { |i|
		if items[i] < pivotItem
			items[i],items[partitionIndex] = items[partitionIndex],items[i]
			partitionIndex = partitionIndex + 1
		end
	}
	
	items[partitionIndex],items[right] = items[right],items[partitionIndex] # Move the pivot value to the new pivot index
	return partitionIndex;
end

def quicksort (items, left, right)
	if left < right
		pivot = left + (right-left)/2
		newPivot = partition(items, left, right, pivot)
		quicksort(items, left, newPivot-1)
		quicksort(items, newPivot+1, right)
	end
end

# Some tests

values = [-2, 9,4,10,12,104,3,5,10,3,2,25,6,182,21,33,23,19,13,38,26,12,3]
puts "original:"
puts values

puts "basicquicksort results: "
values = basicquicksort(values)
puts values

values = [-2, 9,4,10,12,104,3,5,10,3,2,25,6,182,21,33,23,19,13,38,26,12,3]

puts "quicksort results: "
values = [-2, 9,4,10,12,104,3,5,10,3,2,25,6,182,21,33,23,19,13,38,26,12,3]
quicksort(values, 0, values.length-1)
puts values
