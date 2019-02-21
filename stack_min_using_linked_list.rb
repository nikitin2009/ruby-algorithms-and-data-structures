require "./linked_list"

# Stack which stores and keeps track of its minimum value
class MinStack
	attr_reader :min
	
	def initialize
		@list = LinkedList.new
		@min_list = LinkedList.new
	end
	
	def push(a)
		@list.add(0, a)
		
		if @min.nil?
			@min = a
			@min_list.add(0, a)
		else
			@min = a < @min ? @min_list.add(0, a).data : @min
		end
	end
	
	def pop
		removed = @list.remove(0)
		if removed == @min
			@min_list.remove(0)
			@min = @min_list.size == 0 ? nil : @min_list.get(0)
		end
	end
end
