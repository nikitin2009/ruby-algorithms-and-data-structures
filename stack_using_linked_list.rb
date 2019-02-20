require "./linked_list"

class Stack
	def initialize
		@list = LinkedList.new
	end
	
	def push(a)
		@list.add(0, a)
	end
	
  def pop
		@list.remove(0)
	end

	def size
		@list.size
	end
end
